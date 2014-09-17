require_relative '../lib/node'
require_relative '../lib/link'
require_relative '../lib/graphic'

require_relative 'person'
 

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

require 'pry'