source 'https://rubygems.org'

ruby '1.9.2'

gem "rails", "2.3.18"
gem "rake", '0.9.2', :require => false
gem "rdoc", '2.4.3'

gem "mysql2", "0.3.13"
  gem "activerecord-mysql2-adapter", "0.0.3"
gem "shorturl"
gem "hpricot"
gem "highline"
gem "will_paginate", '2.3.16'
gem 'gvis', '< 2.0.0'

# APIs
gem "twitter"
gem "airbrake", "3.1.6"

group :development do
  gem "annotate", :git => "git://github.com/ctran/annotate_models.git"
  gem "ruby-debug19"
  gem "capistrano", :require => false
    gem "capistrano-ext", :require => false
    gem "net-ssh"
    gem "net-ssh-gateway"
    gem "net-scp"
    gem "net-sftp"
  gem "pry"
    gem "pry-remote"
end

group :test do
  gem "factory_girl", '~> 1.3.2'
  gem "rspec", '~> 1.3.1', :require => false
    gem 'test-unit', '1.2.3'
  gem "rspec-rails", '~> 1.3.3', :require => false
end
