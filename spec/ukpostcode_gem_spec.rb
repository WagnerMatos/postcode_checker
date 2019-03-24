RSpec.describe UKPostcode do
  subject(:ukpostcode) { described_class }

  let(:postcode_file) { File.expand_path('spec/fixtures/postcodes_list.csv') }
  let(:postcode_list) { File.read(postcode_file) }
  let(:good_postcodes_csv) { CSV.parse(postcode_list, headers: false) }

  let(:invalid_postcode_file) { File.expand_path('spec/fixtures/invalid_postcodes_list.csv') }
  let(:invalid_postcode_list) { File.read(invalid_postcode_file) }
  let(:invalid_postcodes_csv) { CSV.parse(invalid_postcode_list, headers: false) }

  let(:valid_postcode) { described_class.parse('B3 1SF') }
  let(:invalid_postcode) { described_class.parse('W1YDH') }

  describe 'check UKPostcode gem' do
    it 'expect UKPostcode to validate valid postcodes' do
      good_postcodes_csv.each do |postcode|
        pc = UKPostcode.parse(postcode[0])
        expect(pc.valid?).to be true
      end
    end

    it 'expect UKPostcode gem to invalidate invalid postcodes' do
      invalid_postcodes_csv.each do |postcode|
        pc = UKPostcode.parse(postcode[0])
        expect(pc.valid?).to be false
      end
    end

    it 'must validate valid postcodes' do
      expect(valid_postcode.valid?).to be true
    end

    it 'must invalidate invalid postcode' do
      expect(invalid_postcode.valid?).to be false
    end
  end
end