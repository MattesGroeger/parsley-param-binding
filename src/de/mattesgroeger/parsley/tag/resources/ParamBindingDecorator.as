package de.mattesgroeger.parsley.tag.resources
{
	import org.spicefactory.lib.reflect.Property;
	import org.spicefactory.parsley.config.ObjectDefinitionDecorator;
	import org.spicefactory.parsley.dsl.ObjectDefinitionBuilder;
	import org.spicefactory.parsley.tag.util.ReflectionUtil;

	[Metadata(name="ParamBinding", types="property")]
	public class ParamBindingDecorator implements ObjectDefinitionDecorator
	{
		[DefaultProperty]
		public var key:String;

		[Target]
		public var property:String;

		public function decorate(builder:ObjectDefinitionBuilder):void
		{
			var p:Property = ReflectionUtil.getProperty(property, builder.typeInfo, true, false);
			builder.lifecycle().processorFactory(ParamBindingProcessor.newFactory(p, key));
		}
	}
}