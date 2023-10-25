# Interactor::Strict

A stricter version of [`Interactor`](https://github.com/collectiveidea/interactor).

[![Gem Version](https://img.shields.io/gem/v/interactor-strict.svg)](http://rubygems.org/gems/interactor-strict)
[![Build Status](https://github.com/mjacobus/interactor-strict/actions/workflows/tests.yml/badge.svg)](https://github.com/mjacobus/interactor-strict/actions/workflows/tests.yml)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/mjacobus/interactor-strict.svg)](https://codeclimate.com/github/mjacobus/interactor-strict)
[![Test Coverage](https://img.shields.io/codeclimate/coverage-letter/mjacobus/interactor-strict.svg)](https://codeclimate.com/github/mjacobus/interactor-strict)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)

## Getting Started

Add interactor-strict to your Gemfile and `bundle install`.

```ruby
gem "interactor-strict"
```

## How to use

Include the `Interactor` module as well as the `Intractor::Strict`. That will allow you to use keyword arguments. The of keyword arguments is that you may not miss them, as they will be required by the interpreter. Also, you'll not need to document your params in comments, because the method signature will do that for you.

```ruby
class SomeService
  include Interactor::Strict # that will allow you to use keywords

  # you should now use keyword arguments
  def call(foo:, bar:, other_arg: 'default')
    context.result = [foo, bar, other_arg]
  end
end

SomeService.call(foo: "the-foo", bar: "the-bar")
```

Without the strict interactor module, you would have implemented that service more or less like:

```ruby
class SomeService
  include Interactor

  def call
    raise "missing foo" if context.foo.nil?
    raise "missing bar" if context.bar.nil?
    context.result = [context.foo, context.bar, context.with_default || "default"]
  end
end

SomeService.call(foo: "the-foo", bar: "the-bar")
```

## Credits

This code started as a fork of [mjacobus/interactor](https://github.com/mjacobus/interactor).

## Disclaimer/Opinion

The Interactor gem provides a DSL for a very common design of service classes in ruby.

I don't particularly support this type of service. I don't like its design because this is not really OOP. `Service.call` is a function attached to a namespace.

Also, it imposes on your API/Interface, providing a DSL that brings no real value. You should decide how your services should be designed.

However, if you do think Interactor provides a good pattern - or you happen to work in a project that uses this heavily - you are better off with this stricter extension.
