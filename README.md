Parsley Resource Params
=======================

This parsley extension allows to use any property within your context to be used as param inside your localized texts.

**Use cases for this library:**

- You want to have a very easy way to use params inside your localizations without having to set each individually
- The params inside the localization texts are easy to read/maintain/swap
- You want to have params automatically updated when their values change

**Quick Intro**

Use this tag on any property of any class within your context:

	public class User
	{
		[ResourceParam("username")]
		public var name:String;
	}

Your translation texts can then declare/use it as param:

	<resource-bundle>
		<resource key="hello.world">Hello {username}!</resource>
	</resource-bundle>

You can then use it in your code without having to set any param:

	public class HelloWorldMediator
	{
		[ResourceBinding(bundle="demo",key="hello.world")]
		public var helloWorldLabel:String;		
	}

Whenever you set/update `user.name` the `helloWorldLabel` will be automatically updated.

	user.name = "Heiner";
	trace(mediator.helloWorldLabel); // Hello Heiner!

**Patched parsley-flash**

This extension requires a patched version of parsley-flash that supports using string params ({var}) instead of indexed ones ({0}). The download contains a pre-compiled SWC for the latest parsley 2.4.1 release.

If you want to use a different parsley version, you can apply [the patch](https://github.com/MattesGroeger/parsley-resource-params/resources/parsley-flash.patch) and compile it on your own. You can find a more detailed explanation later in the document.

TODO: Explain the differences in detail...

**Known issues**

Nothing so far.

Usage
-----

**Download**

**Setup**

- Add SWCs
- Initialize `ResourceParamSupport`

**Usage via Metadata Tag**

- Usage of `key` attribute

**Usage via ResourceManager**

**I use Parsley version X, how can I use this extension?**

- Warning: You will have to change your translation texts and code pieces that used the params to the new string-based params
- How to patch/compile Parsley

Change log
----------

**1.0.0** (???)

* **[Added]** Added support for `[ResourceParam]` Metadata tag

Roadmap
-------

- Use variable name if no key is defined
- Anything missing? [Please let me know](https://github.com/MattesGroeger).