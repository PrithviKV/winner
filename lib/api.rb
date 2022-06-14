require 'uri'
require 'net/http'
require 'pry'

module Api

  def self.winner_api_call(id)
    res_body = nil
    begin
      uri = URI("http://localhost:3456/winners/#{id}?is_reliable=true")
      res = Net::HTTP.get_response(uri)
      res_body = res.body if res.is_a?(Net::HTTPSuccess)
    rescue => e
      puts "API call Failed with an error: " + e
    end
    return res_body
  end

  def self.awards_api_call(category,page_number)
    res_body = nil
    page_no = page_number.to_i
    begin
      uri = URI("http://localhost:3456/awards/#{category}?page=#{page_number}?is_reliable=true")
      res = Net::HTTP.get_response(uri)
      res_body = res.body if res.is_a?(Net::HTTPSuccess)
    rescue => e
      puts "API call Failed with an error: " + e
    end
    return res_body
  end
end
