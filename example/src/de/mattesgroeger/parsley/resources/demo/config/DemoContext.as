package de.mattesgroeger.parsley.resources.demo.config
{
	import de.mattesgroeger.parsley.resources.demo.Controller;
	import de.mattesgroeger.parsley.resources.demo.Model;
	import de.mattesgroeger.parsley.resources.demo.View;

	public class DemoContext
	{
		public var model:Model = new Model();
		public var view:View = new View();
		public var controller:Controller = new Controller();
	}
}