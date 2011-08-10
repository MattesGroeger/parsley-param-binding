package de.mattesgroeger.parsley.tag
{
	import de.mattesgroeger.parsley.tag.resources.ParamBindingDecorator;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	import org.spicefactory.lib.reflect.Metadata;

	public class ParamBindingSupport
	{
		private static const log:Logger = LogContext.getLogger(ParamBindingSupport);

		private static var initialized:Boolean = false;

		public static function initialize():void
		{
			if (initialized) 
				return;
			
			log.info("Initialize ParamBinding Support");
			initialized = true;
			
			Metadata.registerMetadataClass(ParamBindingDecorator);
		}
	}
}