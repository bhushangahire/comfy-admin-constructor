# -*- encoding: utf-8 -*-
require File.expand_path('../lib/comfy-admin-constructor/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brian Gilham"]
  gem.email         = ["me@briangilham.com"]
  gem.description   = "ComfyAdminConstructor allows you to quickly and easily build basic admin interfaces in ComfortableMexicanSofa."
  gem.summary       = "Comfy Admin Constructor - Create CMS admin sections in one line"
  gem.homepage      = "https://github.com/bgilham/comfy-admin-constructor"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "comfy-admin-constructor"
  gem.require_paths = ["lib"]
  gem.version       = Comfy::Admin::Constructor::VERSION
end
