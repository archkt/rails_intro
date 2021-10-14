class Movie < ActiveRecord::Base
  def self.all_ratings()
    ['G','PG','PG-13','R']
  end
  
  def self.ratings_to_show(check_list)
    puts(" ")
    puts(" ")
    puts(" ")
    puts(" ")
    puts(" ")
    puts(check_list)
    puts("hi")
    puts(" ")
    puts(" ")
    puts(" ")
    puts(" ")
    puts(" ")
  end
    
end
