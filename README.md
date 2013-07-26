SpreeGlobalize3
===============

Introduction goes here.

Installation
------------

Add spree_globalize3 to your Gemfile:

```ruby
gem 'spree_globalize3'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_globalize3:install
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_globalize3/factories'
```

Copyright (c) 2013 [name of extension creator], released under the New BSD License
