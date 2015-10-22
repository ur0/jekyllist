# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Pull in our module
require File.expand_path('./lib/jekyllist/jekyllist.rb')
include Jekyllist