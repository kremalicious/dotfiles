#!/bin/bash

# Install RVM
curl -sSL https://get.rvm.io | bash

# handle requirements
rvm requirements

# Install a Ruby
rvm install 2.1.4
rvm use --default 2.1.4
rvm rubygems latest

# Install gems
gem install bundler
gem install jekyll