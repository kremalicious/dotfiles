#!/usr/bin/env bash

# Install RVM
curl -sSL https://get.rvm.io | bash

# handle requirements
rvm requirements

# Install a Ruby
rvm install 2.5
rvm use --default 2.5
rvm rubygems latest

# Install gems
gem install \
    bundler \
    jekyll
