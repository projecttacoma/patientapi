source 'https://rubygems.org'

gem 'sprockets'
gem 'coffee-script'
gem 'uglifier'
gem 'rake'
gem 'tilt'

group :test do
  gem 'minitest', '~> 4.0'
  gem 'turn', :require => false

  platforms :ruby do
    gem "libv8" 
    gem "therubyracer", :require => 'v8'
  end
  
  platforms :jruby do
    gem "therubyrhino"
  end
end
