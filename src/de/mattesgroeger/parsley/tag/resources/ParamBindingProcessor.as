package de.mattesgroeger.parsley.tag.resources
{
	import org.spicefactory.lib.reflect.Property;
	import org.spicefactory.parsley.core.lifecycle.ManagedObject;
	import org.spicefactory.parsley.core.registry.ObjectProcessor;
	import org.spicefactory.parsley.core.registry.ObjectProcessorFactory;
	import org.spicefactory.parsley.flash.resources.ResourceManager;
	import org.spicefactory.parsley.processor.util.ObjectProcessorFactories;

	public class ParamBindingProcessor implements ObjectProcessor
	{
		private var target:ManagedObject;
		private var property:Property;
		private var key:String;

		private var resourceManager:ResourceManager;

		public function ParamBindingProcessor(target:ManagedObject, property:Property, key:String)
		{
			this.target = target;
			this.property = property;
			this.key = key;

			resourceManager = ResourceManager(target.context.getObjectByType(ResourceManager));
		}

		public function preInit():void
		{
			resourceManager.params.registerParamBinding(target.instance, property, key);
		}

		public function postDestroy():void
		{
			resourceManager.params.unregisterParam(key);
		}

		public static function newFactory(property:Property, key:String):ObjectProcessorFactory
		{
			var params:Array = [property, key];
			return ObjectProcessorFactories.newFactory(ParamBindingProcessor, params);
		}
	}
}