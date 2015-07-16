require 'sinatra'

require File.expand_path('../../lib/rights_dataset.rb', __FILE__)
require File.expand_path('../../lib/concept_scheme.rb', __FILE__)
require File.expand_path('../../lib/rights_statement.rb', __FILE__)

configure do
  config = YAML.load(File.open(File.expand_path('../../config.yml', __FILE__)))
  
  set :dataset, RightsDataset.new(config['statements_graph'])
end

get '/' do
  redirect '/statements', 303
end

get '/statements' do
  # @todo: create list of all statements?
end

get '/statements/:id' do |id|
  latest = settings.dataset.statements_by_name(id).latest_version
  halt(404) if latest.nil?
  redirect "/statements/#{latest.uri_name}/#{latest.uri_version}", 303
end

get '/statements/:id/:version' do |id, version|
  statement = settings.dataset.statements_by_name(id).get_version(version)
  halt(404) if statement.nil?
  erb :statement, locals: { statement: statement }
end
