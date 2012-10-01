# HookMeUp

This gem lets you create hook methods for any method of any class.
You can create a :before and :after hooks for any method you like.

## Installation

Add this line to your application's Gemfile:

    gem 'hook_me_up'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hook_me_up

## Usage

1. Include HookMeUp in you class
2. call hook_me_up with a method name or array of methods and specify :before hook, :after hook or both.

NOTE: hook_me_up call MUST come after your method definitions

'''ruby
class SomeClass
	include HookMeUp

	def some_method
	end

	def some_other_method
	end

	def before_hook
	end

	def after_hook
	end

	hook_me_up [:some_method, :some_other_method], :before => :before_hook, :after => :after_hook
end
'''

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
