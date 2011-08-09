Parsley Resource Params
=======================

This parsley extension allows to use any property within your context to be used as param inside your localized texts.

**Use cases for this library:**

- You want to have a very easy way to use params inside your localizations without having to set each individually
- The params inside the localization texts are easy to read/maintain/swap
- You want to have params automatically updated when their values change

**What does it do?**

tbd

**Dependencies**

This extension requires a patched version of parsley-flash that supports using string params ({var}) instead of indexed ones ({0}). The download contains a pre-compiled SWC for the latest parsley 2.4.1 release.

If you want to use a different parsley version, you can apply [the patch](https://github.com/MattesGroeger/parsley-resource-params/resources/parsley-flash.patch) and compile it on your own. You can find a more detailed explanation later in the document.

**Known issues**

Nothing so far.

Usage
-----

**Download**

**Setup**

- Add swcs
- Initialize ResourceParamSupport

**Usage via Metadata Tag**

**Usage via ResourceManager**

**How to patch version X of Parsley**

Change log
----------

**1.0.0** (???)

* **[Added]** Added support for `[ResourceParam]` Metadata tag

Roadmap
-------

- Anything missing? [Please let me know](https://github.com/MattesGroeger).