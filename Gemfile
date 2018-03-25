source 'https://rubygems.org'

gem 'sprockets', '~> 2.2'
gem 'coffee-script'
gem 'uglifier'
gem 'rake'
gem 'tilt'

group :test, :ci do
  gem 'test-unit'
  gem 'minitest', '~> 4.0'
  gem 'turn', :require => false
  gem "bundle-audit"

  platforms :ruby do
    gem "libv8" 
    gem "therubyracer", :require => 'v8'
  end
end
