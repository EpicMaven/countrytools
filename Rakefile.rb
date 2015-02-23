#-*-ruby-*-

require 'rubygems'
require 'rdoc/task'
require 'yaml'

lib = File.expand_path("../lib", __FILE__)
$:.unshift lib unless $:.include?(lib)

PKG = 'countrytools'
PKG_NAME = 'CountryTools'

require "#{PKG}/version"

DEPS_FILE = "dependencies.yml"
DEPS_TEXT_FILE = "DEPENDENCIES.md"
VERSION_TEXT_FILE = "VERSION"

# Set constants for the package
eval("NAME = #{PKG_NAME}::NAME")
eval("PACKAGE = #{PKG_NAME}::PACKAGE")
eval("DATE = #{PKG_NAME}::DATE")
eval("VERSION = #{PKG_NAME}::VERSION")
eval("AUTHORS = #{PKG_NAME}::AUTHORS")
eval("MAINTAINER = #{PKG_NAME}::MAINTAINER")
eval("SUMMARY = #{PKG_NAME}::SUMMARY")
eval("DESCRIPTION = #{PKG_NAME}::DESCRIPTION")


desc 'Default: generate gem'
task :default => :gem
task :gem => :build_txt_files
#task :gem => :rdoc


desc 'Generate gem'
task :gem do
  system("gem build #{PKG}.gemspec")
end

desc 'Generate documentation text files'
task :build_txt_files do
  Rake::Task["build_deps_txt_file"].execute
  Rake::Task["build_version_txt_file"].execute
end

desc 'Generate dependency text file from yaml file'
task :build_deps_txt_file do
  deps_file = File.open DEPS_FILE

  deps_txt = File.open(DEPS_TEXT_FILE, "w")
  deps_txt.write("\n")
  deps_txt.write("===#{NAME}  #{VERSION}\n")

  dependencies = YAML.load_file DEPS_FILE
  dependencies.each do |dep|
    str = "  - #{dep["package"]}  #{dep["version"]}"
    str += "  #{dep["max_version"]}" if dep["max_version"]
    str += "\n"
    deps_txt.write str
  end
end

desc 'Generate version text file'
task :build_version_txt_file do
  txt_file = File.open( VERSION_TEXT_FILE, "w" )
  txt_file.write("#{VERSION}\n")
  txt_file.close
end

desc 'Generate RDoc documentation to doc/rdoc/index.html'
Rake::RDocTask.new(:rdoc) do |rd|
  rd.rdoc_dir = 'doc/rdoc'
  rd.main = 'README'
  rd.rdoc_files.include '*\.txt', 'bin/*\.txt', 'lib/**/*\.rb'

  rd.options << "--inline-source"
  rd.options << "--line-numbers"
end
