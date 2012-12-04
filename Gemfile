source :rubygems

gem 'sprockets'
gem 'coffee-script'
gem 'uglifier'
gem 'rake'
gem 'tilt'

group :test do
  gem 'minitest'
  gem 'turn', :require => false

  platforms :ruby do
    gem "therubyracer", :require => 'v8'
  end
  
  platforms :jruby do
    gem "therubyrhino"
  end
end