require 'rake'
require 'rake/testtask'
require 'sprockets'
require 'tilt'
require 'fileutils'

task :default => [:test]
#
# desc "Run basic tests"
Rake::TestTask.new(:test) do |t|
  # t.libs << "test" << "lib"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

# task :test => [:test_unit] do
#
# end
#
# namespace :doc do
#   desc "Generate JS from CoffeeScript"
#   task :generate_js do
#     ctx = Sprockets::Environment.new(File.expand_path("../", __FILE__))
#     Tilt::CoffeeScriptTemplate.default_bare=true
#     ctx.append_path "app/assets/javascripts"
#     api = ctx.find_asset('patient')
#
#     Dir.mkdir('tmp') unless Dir.exists?( 'tmp')
#
#     File.open('tmp/patient.js', 'w+') do |js_file|
#       js_file.write api
#     end
#   end
#
#   desc "Generate docs for patient API"
#   task :js => :generate_js do
#     system 'java -jar ./doc/jsdoc-toolkit/jsrun.jar ./doc/jsdoc-toolkit/app/run.js -t=doc/jsdoc-toolkit/templates/jsdoc -a tmp/patient.js -d=doc/patient-api'
#   end
#
#   task :copydir do
#     Dir.mkdir('patientapi') unless Dir.exists? ('patientapi')
#     cp_r "doc/patient-api", "../query-composer/public/patientapi"
#   end
#
# end
