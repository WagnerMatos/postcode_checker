require 'json'
require_relative '../postcode_checker/connector'

module PostcodeChecker
  # class that handles whitelisting of given postcode
  class Whitelister
    attr_reader :postcode, :lsoas, :postcode_lsoa, :formatted_pc

    def initialize(postcode)
      config_file_path = File.expand_path('lib/config/config.json')
      @config = JSON.parse File.read(config_file_path)
      @postcode = postcode
      @formatted_pc = postcode.delete(" \t\r\n")
      @lsoas = @config['whitelist']['lsoas']
    end

    # we will use this method to validate the input as whole
    # any postcode that would not be found in the postcode.io API
    # such as invalid or incomplete postcode should be validated here to
    # avoid unnecessary HTTP requests.
    # we use the valid?, full? and full_valid? methods from UKPostcode gem.
    # https://github.com/threedaymonk/uk_postcode
    def validate_input
      pc = UKPostcode.parse(postcode)
      pc.valid? && pc.full? && pc.full_valid? ? true : false
    end

    def check_postcode
      pc = Connector.new("http://api.postcodes.io/postcodes/#{formatted_pc}")
      return false unless pc.validate

      @postcode_lsoa = pc.lsoa
    end

    def postcode_service_check
      return false unless validate_input && check_postcode

      valid = false
      lsoas.each do |lsoa|
        valid = true if postcode_lsoa.include? lsoa
      end
      valid
    end
  end
end