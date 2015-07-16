require File.expand_path '../../spec_helper.rb', __FILE__

describe 'routes' do
  before do
    # stub out settings.dataset
    allow(app.dataset).to receive(:repository).and_return(repository)
  end

  let(:repository) do
    RDF::Repository.load('spec/statements.ttl')
  end
  
  describe '/' do
    it 'redirects to /statements' do
      get '/'
      expect(last_response.header['Location']).to end_with '/statements'
    end

    it 'gives status code 303' do
      get '/'
      expect(last_response).to have_attributes status: 303
    end
  end

  describe '/statements' do
    it 'responds ok' do
      get '/statements'
      expect(last_response).to be_ok
    end
  end

  describe '/statements/{id}' do
    it 'responds 404 if no statement has name' do
      get '/statements/fk'
      expect(last_response.status).to eq 404
    end

    it 'gives status code 303' do
      get '/statements/ic'
      expect(last_response)
        .to have_attributes status: 303
    end

    it 'redirects to newest version of statement' do
      get '/statements/ic'
      expect(last_response.header['Location'])
        .to end_with '/statements/ic/0.1'
    end
  end

  describe '/statements/{id}/{version}' do
    it 'gives 404 if no statement has name' do
      get '/statements/fk/0.1'
      expect(last_response.status).to eq 404
    end

    it 'gives 404 if no statement has id' do
      get '/statements/ic/10000.01'
      expect(last_response.status).to eq 404
    end

    context 'with matching statement' do
      it 'responds ok' do
        get '/statements/ic/0.0'
        expect(last_response).to be_ok
      end
    end
  end
end
