require 'active_triples'

class ConceptScheme 
  include ActiveTriples::RDFSource
  
  configure base_uri: 'http://rightsstatements.org/vocab/',
            type: RDF::SKOS.ConceptScheme,
            repository: :statements

  property :title, predicate: RDF::DC.title
  property :identifier, predicate: RDF::DC11.identifier
  property :creator, predicate: RDF::DC.creator
end
