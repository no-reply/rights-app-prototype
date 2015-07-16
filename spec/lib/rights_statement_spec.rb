require 'spec_helper'

describe RightsStatement do
  subject { described_class.new }
  
  describe '#uri_version' do
    it 'returns nil when node' do
      expect(subject.uri_version).to be_nil
    end

    it 'returns second to last uri segment' do
      subject.set_subject! 'http://example.org/0.1/moomin'
      expect(subject.uri_version).to eq '0.1'
    end
  end

  describe '#uri_name' do
    it 'returns nil when node' do
      expect(subject.uri_name).to be_nil
    end

    it 'returns last uri segment' do
      subject.set_subject! 'http://example.org/0.1/moomin'
      expect(subject.uri_name).to eq 'moomin'
    end
  end
end
