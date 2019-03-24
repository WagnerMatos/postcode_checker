require 'faraday'
require 'json'

module PostcodeChecker
  # wrapper connect class using faraday for HTTP requests
  # wwe will use this class to make the request, to check whether
  # the request succeed.
  # TODO review whether validation be should moved to separate class
  # based on business requirements
  class Connector
    attr_reader :response_body, :lsoa

    def initialize(url)
      @api_url = url
      get
    end

    def validate
      @response.status == 200
    end

    def get
      @response = Faraday.get(@api_url)
      @response_body = validate ? JSON.parse(@response.body) : false
      @lsoa = validate ? @response_body['result']['lsoa'] : false
    end
  end
end