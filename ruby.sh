#!/bin/bash

# Install RVM
curl -sSL https://get.rvm.io | bash

# handle requirements
rvm requirements

# Install a Ruby
rvm install 2.2.2
rvm use --default 2.2.2
rvm rubygems latest

# Install gems
gem install bundler jekyll ghi lunchy
