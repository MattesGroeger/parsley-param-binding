/*
 * Copyright (c) 2011 Mattes Groeger
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package 
{
	import de.mattesgroeger.parsley.resources.demo.config.DemoContext;
	import de.mattesgroeger.parsley.resources.demo.message.InitNotification;
	import de.mattesgroeger.parsley.tag.ParamBindingSupport;

	import org.spicefactory.parsley.asconfig.ActionScriptConfig;
	import org.spicefactory.parsley.core.context.Context;
	import org.spicefactory.parsley.core.events.ContextEvent;
	import org.spicefactory.parsley.dsl.context.ContextBuilder;
	import org.spicefactory.parsley.flash.resources.tag.FlashResourceXmlSupport;
	import org.spicefactory.parsley.xml.XmlConfig;

	import flash.display.Sprite;

	public class Demo extends Sprite
	{
		[MessageDispatcher]
		public var dispatcher:Function;
		
		private var context:Context;
		
		public function Demo()
		{
			ParamBindingSupport.initialize();
			FlashResourceXmlSupport.initialize();
			
			var contextBuilder:ContextBuilder = ContextBuilder.newSetup()
			    .viewRoot(stage)
			    .newBuilder();
			
			contextBuilder.config(ActionScriptConfig.forClass(DemoContext))
				.config(XmlConfig.forFile("config/LocaleConfig.xml"));
			
			contextBuilder.objectDefinition()
	    		.forInstance(stage)
	    		.asSingleton()
	    		.register();

			context = contextBuilder.build();
			context.addEventListener(ContextEvent.INITIALIZED, handleContextInitialized);
		}

		private function handleContextInitialized(event:ContextEvent):void
		{
			context.addDynamicObject(this);
			
			dispatcher(new InitNotification());
		}
	}
}
