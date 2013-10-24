# -*- encoding : utf-8 -*-
# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
ENV['GEM_PATH'] ||= "/todpop/shared/bundle/ruby/2.0.0/gems"
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
