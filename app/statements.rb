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
end

get '/statements/:id/:version' do |id, version|
  statements = settings.dataset.statements_by_name(id)
               .select { |s| s.uri_version == version }
  halt(404) if statements.empty?
  # @todo: return 5xx if multiple matching statements are found?
  statement = statements.first
  erb :statement, locals: { statement: statement }
end