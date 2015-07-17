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
  # @return [StatementSet] a set of statements with the same name (i.e. 
  #   the various versions of a statement)
  def statements_by_name(name)
    StatementSet.new(rights_statements.select { |r| r.uri_name == name })
  end

  ##
  # An {Enumerable} of {RightsStatements}.
  class StatementSet
    extend Forwardable
    include Enumerable

    attr_accessor :statements

    def_delegators :statements, :[], :each, :empty?, :last, :to_a, :to_ary

    def initialize(statements = [])
      @statements = statements
    end
    
    ##
    # @return [RightsStatement, nil]
    def latest_version
      statements.sort_by(&:uri_version).last
    end

    ##
    # @param [#to_s] a string representing the version number to retrieve
    # @erturn [RightsStatement, nil]
    #
    # @todo what do we do if we find multiple statements with the same version?
    def get_version(version)
      select { |statement| statement.uri_version == version.to_s }.first
    end
  end
end
