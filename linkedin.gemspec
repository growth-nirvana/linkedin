require_relative 'lib/linkedin/version'

Gem::Specification.new do |spec|
  spec.name          = "linkedin"
  spec.version       = Linkedin::VERSION
  spec.authors       = ["Growth Nirvana"]
  spec.email         = ["matias.code@growthnirvana.com"]

  spec.summary       = "LinkedIn API for Business"
  spec.description   = "spec.summary"
  spec.homepage      = "https://github.com/growth-nirvana/linkedin"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "> 0.18.0", "< 1.0"
end
