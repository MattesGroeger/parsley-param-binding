package de.mattesgroeger.parsley.tag
{
	import de.mattesgroeger.parsley.tag.resources.ResourceParamDecorator;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	import org.spicefactory.lib.reflect.Metadata;

	public class ResourceParamSupport
	{
		private static const log:Logger = LogContext.getLogger(ResourceParamSupport);

		private static var initialized:Boolean = false;

		public static function initialize():void
		{
			if (initialized) 
				return;
			
			log.info("Initialize ResourceParam Support");
			initialized = true;
			
			Metadata.registerMetadataClass(ResourceParamDecorator);
		}
	}
}