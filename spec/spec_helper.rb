require 'rack/test'
require 'rspec'

require File.expand_path '../../app/statements.rb', __FILE__

require 'pry' unless ENV["CI"]

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RSpecMixin }
