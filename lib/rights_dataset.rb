require 'yaml'

require 'active_triples'
require 'rdf/turtle'

class RightsDataset
  extend Forwardable

  attr_accessor :repository

  def_delegator :repository, :query

  def initialize(*graph_urls)
    @repository = RDF::Repository.load(*graph_urls)

    ActiveTriples::Repositories.add_repository :statements, @repository
  end

  ##
  # @return [Array<ConceptScheme>]
  def concept_schemes
    subjects = query([:scheme, 
                      RDF.type, 
                      ConceptScheme.type.first]).subjects
    subjects.map { |uri| ConceptScheme.new(uri) }
  end

  ##
  # @return [Array<RightsStatement>]
  def rights_statements
    subjects = query([:statement, 
                      RDF.type, 
                      RightsStatement.type.first]).subjects
    subjects.map { |uri| RightsStatement.new(uri) }
  end

  ##
  # @param [#to_s] name
  # @return [Array<RightsStatement>]
  def statements_by_name(name)
    rights_statements.select { |r| r.uri_name == name }
  end
end
