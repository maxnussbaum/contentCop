
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "contentCop/version"

Gem::Specification.new do |spec|
  spec.name          = "contentCop"
  spec.version       = ContentCop::VERSION
  spec.authors       = ["Max Nussbaum"]
  spec.email         = ["maxnussbaum@live.com"]

  spec.summary       = "A hackathon project for analyzing music content for explicit-ness"
  spec.homepage      = "http://github.com/maxnussbaum/contentCop"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "http://github.com/maxnussbaum/contentCop"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["rakefile", "{bin,lib,test}/**/*", "README*"] & `git ls-files -z`.split("\0")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "dotenv", "~> 2.6"
  spec.add_development_dependency "rubocop", "~> 0.63.1"
  spec.add_dependency "http", "~> 4.0"
end
