require 'pry'

module Report
  def self.result(start_year, end_year, awards_array, winners_array)

    @r = {}
    (start_year..end_year).each do |year|
      names = []
      awards_winner_array = []
      awards_winner_array = get_awards_for_year(year, awards_array)

      next if awards_winner_array.length == 0

      ids = get_winners_id(awards_winner_array)
      names = get_names(ids, winners_array)
      sorted_names = sort_names_by_last_name(names)
      ages = get_ages(winners_array, ids, year)
      @r[year.to_s] = {
                        "names" => names ,
                        "ages"  => ages
                      }
    end
    return @r
  end
  private

  def self.get_awards_for_year(year, awards_array)
    return awards_array.find_all{ |a| a["year"].to_i == year } if awards_array
  end

  def self.get_winners_id(arr)
    return arr.collect{|x| x["winner_id"].to_i} if arr
  end

  def self.get_ages(winners_array, ids, year)
    return winners_array.select{|x| ids.include?(x["id"].to_i)}.map{|x| year - x["birth_date"].to_i} if winners_array && ids
  end

  def self.get_names(ids, winners_array)
    return winners_array.select{|x| ids.include?(x["id"].to_i)}.map{|x| x["name"]} if winners_array && ids
  end

  def self.sort_names_by_last_name(names)
    return names.sort_by!{|x| x.split.last } if names
  end

end
