require 'spec_helper'

describe RightsDataset::StatementSet do
  it 'acts as an Array'
  
  describe '#latest_version' do
    it 'returns nil if set is empty' do
      expect(subject.latest_version).to be_nil
    end

    it 'returns the highest version number'
  end

  describe '#get_version' do
    it 'returns nil if set is empty' do
      expect(subject.get_version(0)).to be_nil
    end

    it 'returns the highest version number'
  end
end
