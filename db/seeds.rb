require 'open-uri'
path = Rails.root


#populate countries table
open("#{path}/db/data/countries.csv") do |file|
  puts "Populating country table..."
  file.read.each_line do |country|
    arr = country.split(";")
    Country.create!({id:arr[0],name:arr[1]})
  end
  puts "Data entered in the country table"
end if Country.first.nil?

#populate states
open("#{path}/db/data/states.csv") do |file|
  puts "Populating state table..."
  file.read.each_line do |state|
    arr = state.split(";")
    State.create!({id:arr[0],name:arr[1],short_name:arr[2],country_id:arr[3]})
  end
  puts "Data entered in the state table"
end if State.first.nil?

#populate cities
open("#{path}/db/data/cities.csv") do |file|
  puts "Populating city table..."
  file.read.each_line do |city|
    arr = city.split(";")
    City.create!({id:arr[0],name:arr[1],state_id:arr[2]})
  end
  puts "Data entered in the city table"
end if City.first.nil?


categories = %W(Retrato Casamento Street)
categories.each do |category|
	Category.where(description:category).first_or_create!
end
