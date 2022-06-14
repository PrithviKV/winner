require 'json'
require_relative 'lib/api'
require_relative 'lib/report'

module Main
  include Api
  include Report

  CATEGORIES = ["chemistry", "physics", "peace", "literature", "medicine", "economics"]
  API_RESP_LIMIT = 5

  def self.make_winner_api_call(id)
    res_body = Api.winner_api_call(id)
     if res_body != nil
       return JSON.parse(res_body)
     end
     return
  end

  def self.get_winners_data(start_year, end_year, awards_data)
    winners = []
    for element in awards_data
      year = element["year"].to_i
      if year >= start_year && year <= end_year
        api_resp = make_winner_api_call(element["winner_id"].to_i)
        winners.append(api_resp) if api_resp
      end
    end
    return winners
  end

  def self.make_awards_api_call(category, page)
    res_body = Api.awards_api_call(category, page)
    if res_body != nil
      return JSON.parse(res_body)
    end
    return
  end

  def self.get_awards_data(category)
   page = 1
   resp_array = []
   api_resp = make_awards_api_call(category, page) #page = 1 first time  if length == 5 page increment call api
   if api_resp != nil
     resp_array.append(api_resp)
     while api_resp.length == API_RESP_LIMIT
       page += 1
       api_resp = make_awards_api_call(category, page)
       if api_resp != nil
         resp_array.append(api_resp)
       else
         return resp_array
       end
     end
   else
    return resp_array
   end
  end


  def self.valid_category?(category)
    if CATEGORIES.include? category
      return true
    else
      puts "Please input a valid category :[chemistry, physics, peace, literature, medicine, economics]"
      return false
    end
  end

  def self.run(args)
    if args.length == 3
      start_year = args[0].to_i
      end_year = args[1].to_i
      category = args[2].downcase
    else
      puts "Please run this program with 3 arguments----> start_year, end_year, category"
      return
    end

    if valid_category?(category)
      awards_array = get_awards_data(category)
      a = awards_array.flatten
      winners_array = get_winners_data(start_year, end_year, a)
      w = winners_array.flatten
      result = Report.result(start_year, end_year, a, w)
    else
      return
    end
    puts result
  end

end

Main.run(ARGV)
