rails-engine-spec-template
==========================

Engines in Rails are awesome for many reasons. [Here's a good article about them](https://techblog.livingsocial.com/blog/2014/01/24/open-sourcing-with-rails-engines/ "About Rails engines").

Setting up the typical Rails BDD testing environment with engines is a bit tricky. Rspec in particular is challenging. There's no single source for how to do it, so over a day I compiled knowledge from various places on the Internet and worked through bugs until it was shiny and issue-free. This ```template.rb``` is a result of that work.

Save yourself some hair-pulling induced baldness and use this template.

Installation
------------

Click on each individual file on Github and then copy & paste it into your favorite editor, like Notepad.

Just kidding. ```git clone``` this repository to somewhere that you store code and use it from there. 

Usage
-----

When creating a rails engine, use ```-T``` to disable test creation. A dummy app will be automatically generated in the correct place in the rspec recipe. You can also use ```-B``` to skip bundler, because this package does it for you, but it won't hurt anything if you forget.

**Example usage:**

```rails plugin new engine_name --mountable -B -T -m ./rails-engine-spec-template/template.rb```

This engine template was tested with Ruby 2.1 and Rails 4.0.4, though I don't see any reason it won't work on earlier or later versions. [File an issue if you have one](https://github.com/bbugh/rails-engine-spec-template/issues/ "Issues").

**Quirks:**

* awesome_print and hirb both require some extra setup. See the [pry FAQ](https://github.com/pry/pry/wiki/FAQ) for instructions.
* When you generate a factory with factory_girl, it doesn't properly use the engine namespace. You have to manually edit the ```class:``` attribute to something like ```:class => "EngineName::MyClass"```, but thankfully you only have to do this once.
* When you use any Rspec tests that use routes, you have to specify ```use_route: :engine_name``` on any calls. For example ```get '/', use_route: :my_engine```. It's annoying, but that's what the official docs say. I have figured out yet if you can safely alias the methods in the engine.

Gem recipes
-----------

This is a pretty standard Rails BDD setup, though it's opinionated because it's what I want to use. If you don't like it, you can... disable any of the recipes by editing the ```template.rb``` file and removing it from the ```RECIPES``` array.

### rspec

* rspec-rails
* capybara
* factory_girl_rails
* ffaker

### guard

* guard-rspec
* guard-rails

### developer_gems

* thin
* pry-doc
* pry-rails
* better_errors (and binding_of_caller)
* awesome_print (setup: [How can I use awesome_print with Pry?](https://github.com/pry/pry/wiki/FAQ#awesome_print))
* hirb (setup: [How can I use the Hirb gem with Pry?](https://github.com/pry/pry/wiki/FAQ#hirb))

More Information
----------------

* [Rails Engine Testing with Rspec, Capybara, and Factory Girl](http://viget.com/extend/rails-engine-testing-with-rspec-capybara-and-factorygirl) - The original guide this was based on, which was 70% of the way there.
* [Open Sourcing with Rails Engines](https://techblog.livingsocial.com/blog/2014/01/24/open-sourcing-with-rails-engines/) - Good information about why you should use engines.
* [Rails Guides: Engines](http://guides.rubyonrails.org/engines.html) - A good (but incomplete) resource on using engines.

Credits
-------

I'm Brian Bugh and I made this. [Look at me on the Internet!](http://brianbugh.me)

Contributing
------------

Fork and pull request.

License
-------

This is free software, and may be redistributed under the terms specified in the [LICENSE](https://github.com/bbugh/rails-engine-spec-template/blob/master/LICENSE) file.
