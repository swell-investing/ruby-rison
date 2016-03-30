Gem::Specification.new do |s|
  s.name = 'rison'
  s.version = '2.1.0'
  s.license = 'MIT'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Tim Fletcher']
  s.email = ['mail@tfletcher.com']
  s.homepage = 'http://github.com/tim/ruby-rison'
  s.description = 'A Ruby implementation of Rison (http://mjtemplate.org/examples/rison.html)'
  s.summary = 'See description'
  s.files = Dir.glob('{lib,spec}/**/*') + %w(README.md Rakefile.rb rison.gemspec License.txt)
  s.add_dependency('parslet', '~> 1.4')
  s.add_development_dependency('rake', '~> 10')
  s.add_development_dependency('minitest', '~> 5')
  s.require_path = 'lib'
end
