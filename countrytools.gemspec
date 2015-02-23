#-*-ruby-*-

require 'yaml'

lib = File.expand_path("../lib", __FILE__)
$:.unshift lib unless $:.include?(lib)

PKG_NAME = 'CountryTools'
PKG = 'countrytools'

require "#{PKG}/version"

DEPS_FILE = "dependencies.yml"

# Set constants for the package
eval("NAME = #{PKG_NAME}::NAME")
eval("PACKAGE = #{PKG_NAME}::PACKAGE")
eval("DATE = #{PKG_NAME}::DATE")
eval("VERSION = #{PKG_NAME}::VERSION")
eval("LICENSE = #{PKG_NAME}::LICENSE")
eval("MAINTAINER = #{PKG_NAME}::MAINTAINER")
eval("AUTHORS = #{PKG_NAME}::AUTHORS")
eval("EMAIL = #{PKG_NAME}::EMAIL")
eval("HOMEPAGE = #{PKG_NAME}::HOMEPAGE")
eval("SUMMARY = #{PKG_NAME}::SUMMARY")
eval("DESCRIPTION = #{PKG_NAME}::DESCRIPTION")

Gem::Specification.new do |s|
  s.name = PACKAGE
  s.version = VERSION
  s.date = DATE
  s.license = LICENSE
  s.author = MAINTAINER
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.authors = AUTHORS
  s.summary = SUMMARY
  s.description = DESCRIPTION

  s.files = Dir.glob("{bin,doc,excel,lib}/**/*") + Dir.glob("*.txt")

  s.require_path = 'lib'
  s.has_rdoc = true
  s.bindir = 'bin'

  #s.email = '-'
  #s.homepage = ""
  s.rubyforge_project = PACKAGE

  dependencies = YAML.load_file DEPS_FILE
  dependencies.each do |dep|
    if dep["package"].match /ruby/i
      s.required_ruby_version = "#{dep["version"]}"
    else
      if dep["max_version"]
        s.add_dependency dep["package"], "#{dep["version"]}", "#{dep["max_version"]}"
      else
        s.add_dependency dep["package"], "#{dep["version"]}"
      end
    end
  end

  s.rdoc_options = ['--inline-source', '--line-numbers', 'main', 'README.txt']
  s.extra_rdoc_files = Dir.glob("*.txt") + Dir.glob("doc/**/*")

end
