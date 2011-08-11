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
			var k:String = (key != null && key != "") ? key : p.name;
			builder.lifecycle().processorFactory(ParamBindingProcessor.newFactory(p, k));
		}
	}
}