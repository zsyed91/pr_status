# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pr_status/version'

Gem::Specification.new do |spec|
  spec.name          = 'pr_status'
  spec.version       = PrStatus::VERSION
  spec.authors       = ['Zshawn Syed']
  spec.email         = ['zsyed91@gmail.com']

  spec.summary       = 'Get the count of pull requests opened'
  spec.description   = 'Get the count of pull requests opened from the first of the month'
  spec.homepage      = 'https://github.com/zsyed91/pr_status'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency('octokit', '~> 4.0')
end
