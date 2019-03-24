RSpec.describe PostcodeChecker::Connector do
  subject(:connector) { described_class.new('http://api.postcodes.io/postcodes/BH151EQ') }

  describe 'Connector class' do
    it 'must validate response' do
      expect(connector.validate).to be true
    end

    it 'must return a hash as response body' do
      expect(connector.response_body.class).to be Hash
    end

    it 'response body must have status' do
      expect(connector.response_body['status']).to eq 200
    end
  end
end