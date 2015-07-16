require 'active_triples'

class RightsStatement
  include ActiveTriples::RDFSource
  
  configure base_uri: 'http://rightsstatements.org/vocab/',
            type: RDF::DC.RightsStatement,
            repository: :statements

  property :prefLabel, predicate: RDF::SKOS.prefLabel
  property :title, predicate: RDF::DC.title
  property :identifier, predicate: RDF::DC11.identifier

  property :definition, predicate: RDF::SKOS.definition
  property :creator, predicate: RDF::DC.creator

  property :hasVersion, predicate: RDF::DC.hasVersion
  property :modified, predicate: RDF::DC.modified

  property :closeMatch, predicate: RDF::SKOS.closeMatch
  property :relatedMatch, predicate: RDF::SKOS.relatedMatch
  property :inScheme, predicate: RDF::SKOS.inScheme

  ##
  # @return [String, nil] returns the version segement of the URI; nil if self
  #   is a bnode
  def uri_version
    return nil if node?
    rdf_subject.to_s.split('/')[-2]
  end

  ##
  # @return [String, nil] returns the statement name (last) segement of the uri;
  #   nil if self is a bnode
  def uri_name
    return nil if node?
    rdf_subject.to_s.split('/')[-1]
  end
end
