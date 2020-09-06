class Conversion < ApplicationService
  require 'httparty'


  def initialize(origin_currency,target_currency,amount)
    @origin_currency = origin_currency
    @target_currency = target_currency
    @amount = amount
  end

  def call
    key = ENV["FIXER_KEY_API"]
    url = "http://data.fixer.io/api/latest?access_key=#{key}&base=#{@origin_currenc}&symbols=#{@target_currency}"
    response = HTTParty.get(url)
    convertion_rate=response.parsed_response["rates"]["USD"]
    @amount * convertion_rate
  end
end
