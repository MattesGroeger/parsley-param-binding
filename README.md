Parsley Param Binding
=====================

This Parsley extension enhances the native *parsley-flash* library which provides logging and localization for pure AS3 applications. It enhances especially the way you can use variables (params) within your localized texts. For a general introduction into parsley localization [read its documentation](http://www.spicefactory.org/parsley/docs/2.4/manual/resources.php#intro).

This extension allows to use any property within your context to be used as param inside your localized texts. You just have to bind the property to a parameter by using the `[ParamBinding]` metadata tag and it will set the value in all your localized texts automatically.

Because the native localization library supports only indexed params like `{0}`, `{1}`, ... you need a patched version. This version allows human readable params like `{var}`. For more information on the implications the patched version has, please read on at **Patched parsley-flash.swc**.

**Why should I use this extension?**

- Better readable translation text
- You declare a param binding once instead of setting it for each translation text individually
- The translations update automatically as soon as the binded property value changes*
- The binded params can be used in any translation without changes in code
- Param bindings use reflection, so it can not break due to re-factorings

*) You have to re-apply the text to the TextField yourself.

**Quick Intro**

Lets assume you want to use the param *username* in your translation text:

	<resource-bundle>
		<resource key="hello.user">Hello {username}!</resource>
	</resource-bundle>

To map the value for this param, place this metadata tag on top of the corresponding property (class `User` must be within the `Context`):

	public class User
	{
		[ParamBinding("username")]
		public var name:String;
	}

You can then use the translation without having to set any param. Whenever you set/update `user.name` the `helloUserLabel` will be automatically updated.

	public class HelloUserMediator
	{
		[Inject]
		public var user:User;
		
		[Inject]
		public var resourceManager:ResourceManager;
		
		[Init]
		public function init():void
		{
			user.name = "Heiner"; // set the username
			var label:String = resourceManager.getMessage("demo", "hello.user");
			trace(label); // output: Hello Heiner!
		}
	}

Patched parsley-flash.swc
-------------------------

This extension requires a patched version of parsley-flash.

**What is the difference to the normal version?**

In the original version you can already use variables (params) in your localization texts:

	<resource-bundle>
		<resource key="popup.purchase.buy">Buy {0} items for {1} {2}</resource>
	</resource-bundle>

This syntax has two main disadvantages:

* It is eventually very hard to read for a translator (What is {1} and {2}?)
* If you change the order for certain languages it gets even more obfuscated

That's why the patched version replaces the index-based params with a human readable format:

	<resource-bundle>
		<resource key="popup.purchase.buy">Buy {amount} items for {price} {currency}</resource>
	</resource-bundle>

**How do I set the values now?**

As usual you can do it by using the `ResourceManager`. But instead of defining an `Array` of params you define an `Object`:

	[Inject]
	public var resourceManager:ResourceManager;
	
	private function setText():void
	{
		resourceManager.getMessage("popup.purchase.buy", "demo", {amount: 2, price: 20, currency: "€"});
		
		// OR like this:
		resourceManager.getBundle("demo")
			.getMessage("popup.purchase.buy", {amount: 2, price: 20, currency: "€"});
	}

Note: The params object is also optional now.

**What else?**

For this way of localization you still have to communicate to the translators which params can be used in which string. But sometimes you have params that you want to use potentially in any translation text (e.g. the user name).

To avoid having to pass these params for each translation call like shown in the previous section, the patched version provides support for *global* params. This means a param is registered once in a central lookup table and will than be applied whenever it is found within a translation string. 

*Note:* The params object always has precedence over the lookup table. So you can always override the *global* values.

The `ResourceManager` interface provides a new accessor for the `Params` manager. With this interface you can register and unregister *global* params:

	[Inject]
	public var resourceManager:ResourceManager;
	
	[Inject]
	public var user:User;
	
	private function init():void
	{
		resourceManager.params.registerParam("username", user.name); // changes to user.name won't be reflected in the translations
		resourceManager.params.registerParam("br", "\n");
	}

**What does this mean for my existing code?**

If you already used params in your translation strings, you will have to change them to the new string based param names. 

This includes:

* Updating all translation texts by changing params from {i} to {key}
* Change all code pieces where you set the param values from [value] to {key: value}
* Eventually you can directly get rid of some param mappings if you define them as [ParamBindings] like described in the following sections

**Get the patched version**

The download contains a pre-compiled SWC for the latest Parsley 2.4.1 release. If you want to use a different Parsley version, you can apply [the patch](https://github.com/MattesGroeger/parsley-resource-params/resources/parsley-flash.patch) and compile it on your own. You will find a more detailed explanation further down in this document.

Usage
-----

**Download**

Download the latest version from [the downloads page](https://github.com/MattesGroeger/parsley-resource-params/downloads). The zip file contains all necessary SWC files.

**Setup**

1. Place the following SWC files into your libs folder and/or add them to your classpath: 

 * parsley-flash-2.4.1-PATCHED.swc *
 * spicelib-flash-2.4.0.swc *
 * parsley-resource-params-1.0.0.swc

 *) You can also use your own (patched) version of Parsley and Spicelib like described further down

2. To make this extension working you will have to initialize the `ParamBindingSupport` **before** you initialize your context.

 `ParamBindingSupport.initialize();`

**Binding via Metadata Tag**

The easiest way to bind a class property to a param is to use the `[ParamBinding]` metadata tag. Be carful, it can only be used on classes that are managed by Parsley. This means the class needs to be registered in a Parsley Context. Therefore it doesn't matter if the class was registered with XML- or ActionScript-Config or if it was added as `DynamicObject`.

	[ParamBinding]
	public var name:String;

The above example will use the property name as key for the param ({name}). Use this version with care as it would also change the key as soon as you rename the property. 

Better use the following syntax:

	[ParamBinding("name")]
	public var name:String;

Optionally you can also declare the "key" for better readability. But the result is the same.

	[ParamBinding(key="name")]
	public var name:String;

**Binding via ResourceManager**

In case you want to have some static replacements which don't change over time, you can also use a different approach.

You would use the injected `ResourceManager` to register a static param. In this example we replace all `{br}` params with proper `\n` line-breaks.

	[Inject]
	public var resourceManager:ResourceManager;

	private function init():void
	{
	    resourceManager.params.registerParam("br", "\n");
	}

You can also unregister the param whenever you want:

	resourceManager.params.unregisterParam("br");

**Usage of translation string**

The recommended way of applying the translation text to a text field is using `ResourceManager.getMessage()`. You could also use the `[ResourceBinding]` metadata tag. But than you have to make sure the binded param was set before the class got initialized. Because metadata tags are only processed once on initialization, later changes to the binded property won't be reflected in the localized text.

For an example see the first section *Quick intro*. Note that you don't have to set the *username* value here.

**I use Parsley version X, how can I use this extension?**

If the Parsley version doesn't fit the version delivered with this library, you can build the patched version on your own. Therefore you find a patch file in the `resources` folder. Choose a tool of your choice to apply the patch on the Parsley sources.

In Eclipse you can just:

* Right click on the Parsley project
* Choose Team > Apply Patch ...
* Select the patch file from the download zip
* Afterwards you can re-compile Parsley

Change log
----------

**1.0.0** (2011/08/11)

* **[Added]** Added support for `[ParamBinding]` Metadata tag

Roadmap
-------

- Build patched Version against Parsley 2.4.1
- Anything missing? [Please let me know](https://github.com/MattesGroeger).