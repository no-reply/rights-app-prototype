require 'spec_helper'

describe RightsDataset do
  let(:graph_url) do
    'https://raw.githubusercontent.com/rightsstatements/' \
    'data-model/master/rights-statements.ttl'
  end
  
  subject { described_class.new graph_url }

  describe '#repository' do
    it 'has a repository' do
      expect(subject.repository).to be_a RDF::Repository
    end

    it 'loads the statements into the repository' do
      expect(subject.repository).not_to be_empty
    end
  end

  describe '#concept_schemes' do
    it 'returns some concept schemes' do
      expect(subject.concept_schemes).not_to be_empty
    end

    it 'gives a ConceptScheme for each in repository' do
      subject.concept_schemes.each do |scheme|
        expect(scheme).to be_a ConceptScheme
      end
    end
  end

  describe '#rights_statements' do
    it 'returns some rights statements' do
      expect(subject.rights_statements).not_to be_empty
    end

    it 'returns statements as RightsStatements' do
      subject.rights_statements.each do |scheme|
        expect(scheme).to be_a RightsStatement
      end
    end
  end

  describe '#statements_by_name' do
    it 'gives a non-empty result' do
      expect(subject.statements_by_name('ic-permission')).not_to be_empty
    end

    it 'gives statements by name' do
      subject.statements_by_name('ic-permission').each do |s|
        expect(s.uri_name).to eq 'ic-permission'
      end
    end
  end
end
