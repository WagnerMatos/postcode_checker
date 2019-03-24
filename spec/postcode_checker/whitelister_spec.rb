RSpec.describe PostcodeChecker::Checker do
  let(:config_file) { File.expand_path('lib/config/config.json') }
  let(:valid_pc) { described_class.new('SE1 7QD') }
  let(:invalid_pc) { described_class.new('BH15 1EQ') }

  describe 'whitelist' do
    it 'check whether a config file exist' do
      expect(File.file?(config_file)).to be true
    end

    it 'must whitelist an area' do
      expect(valid_pc.postcode_service_check).to be true
    end

    it 'must blacklist postcodes outside whitelisted areas' do
      expect(invalid_pc.postcode_service_check).to be false
    end
  end
end