require 'spec_helper'
require 'hook_me_up/sample_class'

describe HookMeUp do
	let(:sample) { SampleClass.new }

	it "hooks a before and after methods" do
		class << sample
			include HookMeUp

			hook_me_up :method_one, :before => :before_hook, 
				:after => :after_hook

			def before_hook(*args)
			end

			def after_hook(*args, result)
			end
		end

		sample.should_receive(:before_hook).with('args')
		sample.should_receive(:after_hook).with('args', 'args')

		sample.method_one('args').should eq 'args'
	end

	it "can receive a block as a before or after hooks" do
		class << sample
			include HookMeUp

			attr_accessor :before, :after

			hook_me_up :method_one, :before => lambda{ |sender, *args| sender.before = true }, 
				:after => lambda{ |sender, *args, result| sender.after = true }
		end

		sample.method_one('args').should eq 'args'

		sample.before.should eq true
		sample.after.should eq true
	end


	it "can receive multiple methods to hook" do
		class << sample
			include HookMeUp

			attr_accessor :before, :after

			hook_me_up :method_one, :method_two, :before => :before_hook, :after => :after_hook

			def before_hook(*args)
			end

			def after_hook(*args)
			end
		end

		sample.should_receive(:before_hook).exactly(2)
		sample.should_receive(:after_hook).exactly(2)

		sample.method_one('args').should eq 'args'
		sample.method_two.should eq 'method_two'
	end

	it "should not call before or after if not defined" do
		class << sample
			include HookMeUp

			hook_me_up :method_one, :before => :before_hook

			def before_hook(*args)
			end

			def after_hook(*args, result)
			end
		end

		sample.should_receive(:before_hook).with('args')
		sample.should_not_receive(:after_hook)

		sample.method_one('args').should eq 'args'
	end

	context "when disabled" do
		before do
			class << sample
				include HookMeUp

				hook_me_up :method_one, :before => :before_hook, :after => :after_hook

				def before_hook(*args)
				end

				def after_hook(*args)
				end
			end
		end

		describe "no_hook" do
			it "doesn't call before hook" do
				sample.should_not_receive(:after_hook)
				sample.method_one('args', no_hook: true).should eq 'args'
			end

			it "doesn't call after hook" do
				sample.should_not_receive(:after_hook)
				sample.method_one('args', no_hook: true).should eq 'args'
			end
		end

		describe "no_before_hook" do
			it "doesn't call before hook" do
				sample.should_not_receive(:before_hook)
				sample.method_one('args', no_before_hook: true).should eq 'args'
			end

			it "calls the after hook" do
				sample.should_receive(:after_hook)
				sample.method_one('args')
			end
		end

		describe "no_after_hook" do
			it "doesn't call after hook" do
				sample.should_not_receive(:after_hook).with('args', 'args')
				sample.method_one('args', no_after_hook: true).should eq 'args'
			end

			it "calls the before hook" do
				sample.should_receive(:before_hook)
				sample.method_one('args')
			end
		end

	end
end