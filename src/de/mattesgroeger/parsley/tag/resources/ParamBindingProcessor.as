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