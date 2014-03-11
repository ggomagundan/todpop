# -*- encoding : utf-8 -*-
# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Todpop::Application.initialize!

Rails.logger = Logger.new(STDOUT)
Rails.logger.level = 0
