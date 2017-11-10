source 'https://rubygems.org'
gemspec

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
