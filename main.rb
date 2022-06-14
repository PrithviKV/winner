

module Main

  CATEGORIES = ["chemistry", "physics", "peace", "literature", "medicine", "economics"]

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
    else
      return
    end
    
  end

end

Main.run(ARGV)
