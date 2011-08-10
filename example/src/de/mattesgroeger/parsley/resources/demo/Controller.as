package de.mattesgroeger.parsley.resources.demo
{
	import org.spicefactory.parsley.flash.resources.ResourceManager;
	import de.mattesgroeger.parsley.resources.demo.message.ModelUpdateNotification;
	import de.mattesgroeger.parsley.resources.demo.message.InitNotification;

	public class Controller
	{
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Inject]
		public var model:Model;
		
		[Inject]
		public var resourceManager:ResourceManager;
	
		[ResourceBinding(bundle="core",key="currency")]
		public var currency:String;
		
		[MessageHandler(order="1")]
		public function handleInit(message:InitNotification):void
		{
			model.name = "Heiner";
			
			resourceManager.params.registerParam("currency", currency);
		}

		public function changeAmount(amount:int):void
		{
			model.amount = amount;
			
			dispatcher(new ModelUpdateNotification());
		}
	}
}