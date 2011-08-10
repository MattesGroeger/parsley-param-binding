package de.mattesgroeger.parsley.resources.demo
{
	public class Model
	{
		[ParamBinding("username")]
		public var name:String;
		
		[ParamBinding("amount")]
		public var amount:uint = 0;
		
		[ParamBinding("price")]
		public var price:Number = 12;
	}
}
