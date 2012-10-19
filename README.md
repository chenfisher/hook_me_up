
# HookMeUp

This gem lets you create hook methods for any method of any class.  
You can create a `:before` and `:after` hooks for any method you like.

## Installation

Add this line to your application's Gemfile:

    gem 'hook_me_up'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hook_me_up

## Usage

1. Include HookMeUp in your class
2. call `hook_me_up` with a method name or array of methods and specify `:before` hook, `:after` hook or both.

NOTE: `hook_me_up` call **must** come after your method definitions


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


###You can pass lambda to the hooks instead of methods

	hook_me_up :some_method, :before => lambda{ |sender, *args| sender.do_something(args) },
			:after => lambda{ |sender, *args, result| sender.do_something_else(result) }

## Arguments

### When called with method names
The `:before` hook is passed with an optional `*args`, which are the arguments passed to the original method:  

	def before(*args)
	end

The `:after` hook is passed with optional two arguments:  

	def after(*args, result)
	end

Where `result` is the result of the original method

### When called with lamdba
There is an additional, mandatory, argument: **sender**, which is the class instance of the original method:

	hook_me_up :some_method, :before => lambda{ |sender, *args| ... },
		:after => lambda{ |sender, @args, result| ... }


## Examples (Controller)
The following two examples show how to use `hook_me_up` in a controller,
which actually does the same as `before_filter`; this is just for the sake of demonstration and can be done with models, 'regular' classes and so on...


### With lambda
	class HomeController < ApplicationController
		include HookMeUp

		def index
			render :text => "hello there #{params[:name]}"
		end

		hook_me_up :index, 
			:before => lambda{ |controller, *args| controller.params[:name] = controller.current_user.name }
	end


### With method name
	class HomeController < ApplicationController
		include HookMeUp

		def index
			render :text => "hello there #{params[:name]}"
		end

		hook_me_up :index, 
			:before => :do_this_before

		private

			def do_this_before
				params[:name] = current_user.name
			end
	end


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
