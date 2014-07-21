#!/bin/bash

# Install RVM
curl -sSL https://get.rvm.io | bash

# Install a Ruby
rvm install 2.1.1
rvm use 2.1.1
rvm rubygems latest

# Install gems
gem install bundler
gem install jekyll