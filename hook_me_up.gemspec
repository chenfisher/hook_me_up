# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hook_me_up/version'

Gem::Specification.new do |gem|
  gem.name          = "hook_me_up"
  gem.version       = HookMeUp::VERSION
  gem.authors       = ["Chen Fisher"]
  gem.email         = ["chen.fisher@gmail.com"]
  gem.description   = %q{Lets you hook any method class with :before and :after hooks}
  gem.summary       = %q{This gem lets you hook and method in any class with a before and after hooks}
  gem.homepage      = ""

  gem.add_development_dependency "rspec"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
