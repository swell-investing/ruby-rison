require 'rake'
require 'rake/testtask'

GEMSPEC = Gem::Specification.new do |s|
  s.name = 'rison'
  s.version = '1.2.1'
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = false
  s.summary = 'Pure Ruby parser for Rison (http://mjtemplate.org/examples/rison.html)'
  s.description = s.summary
  s.author = 'Tim Fletcher'
  s.email = 'twoggle@gmail.com'
  s.homepage = 'http://rison.rubyforge.org/'
  s.files = Dir.glob('{lib,test}/**/*') + %w( COPYING.txt Rakefile.rb README.html )
  s.require_paths = ['lib']
  s.add_dependency 'dhaka'
end

desc 'Run all the tests'
Rake::TestTask.new do |t|
  t.verbose = true
  t.ruby_opts = ['-rubygems']
end

namespace :stdin do
  $:.unshift 'lib'
  require 'rison'
  require 'pp'

  task :lex do
    pp Rison.lex($stdin.read.chomp).to_a
  end
  task :parse do
    parsed = Rison.parse(Rison.lex($stdin.read.chomp))

    if parsed.has_error?
      p parsed
    else
      pp Rison.load(parsed)
    end
  end
end

desc 'Regenerate the compiled parser'
task :regen do
  $:.unshift 'lib'

  require 'rison/grammar'
  require 'dhaka'

  parser = Dhaka::Parser.new(Rison::Grammar)

  source = [
    "require 'dhaka'",
    "require 'rison/grammar'",
    '',
    'module Rison',
      parser.compile_to_ruby_source_as(:Parser).gsub(/^/, '  '),
    'end'
  ]

  File.open('lib/rison/parser.rb', 'w+') { |f| f.puts source * "\n" }
end
