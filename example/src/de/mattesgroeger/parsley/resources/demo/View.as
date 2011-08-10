package de.mattesgroeger.parsley.resources.demo
{
	import org.spicefactory.parsley.flash.resources.events.LocaleSwitchEvent;
	import org.spicefactory.parsley.flash.resources.Locale;
	import com.bit101.components.ComboBox;
	import com.bit101.components.VBox;
	import de.mattesgroeger.parsley.resources.demo.message.ModelUpdateNotification;
	import de.mattesgroeger.parsley.resources.demo.message.InitNotification;

	import com.bit101.components.HBox;
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;

	import org.spicefactory.parsley.flash.resources.ResourceManager;

	import flash.display.Stage;
	import flash.events.Event;

	public class View
	{
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject]
		public var viewRoot:Stage;
		
		[Inject]
		public var model:Model;
		
		[Inject]
		public var controller:Controller;
		
		[Inject]
		public var resourceManager:ResourceManager;
		
		private var welcomeLabel:Label;
		private var purchaseLabel:Label;
		private var amountStepper:NumericStepper;
		private var comboBox:ComboBox;

		[Init]
		public function init():void
		{
			var vBox:VBox = new VBox(viewRoot, 10, 10);
			vBox.spacing = 10;
			
			welcomeLabel = new Label(vBox);
			purchaseLabel = new Label(vBox);
			
			amountStepper = new NumericStepper(vBox);
			amountStepper.minimum = 0;
			amountStepper.maximum = 99;
			amountStepper.addEventListener(Event.CHANGE, handleAmountChange);
			
			comboBox = new ComboBox(vBox);
			comboBox.addItem({label:"English", locale:"en"});
			comboBox.addItem({label:"Deutsch", locale:"de"});
			comboBox.numVisibleItems = 2;
			comboBox.selectedIndex = 0;
			comboBox.addEventListener(Event.SELECT, handleLanguageSelected);
			
			resourceManager.addEventListener(LocaleSwitchEvent.COMPLETE, handleLocaleSwitchEvent);
		}

		[MessageHandler(order="2")]
		public function handleInit(message:InitNotification):void
		{
			updateView();
		}

		[MessageHandler]
		public function handleModelUpdate(message:ModelUpdateNotification):void
		{
			updateView();
		}

		private function handleLocaleSwitchEvent(event:LocaleSwitchEvent):void
		{
			updateView();
		}

		private function updateView():void
		{
			welcomeLabel.text = resourceManager.getMessage("welcome.label", "core");
			purchaseLabel.text = resourceManager.getMessage("purchase.label", "core", {price: (model.price * model.amount)});
			amountStepper.value = model.amount;
		}

		private function handleAmountChange(event:Event):void
		{
			controller.changeAmount(amountStepper.value);
		}

		private function handleLanguageSelected(event:Event):void
		{
			resourceManager.currentLocale = new Locale(comboBox.selectedItem["locale"]);
		}
	}
}