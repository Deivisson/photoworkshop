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

#categories
open("#{path}/db/data/categories.txt") do |file|
  puts "Populating categories table..."
  file.read.each_line do |category|
    Category.where(description:category.gsub("\n","")).first_or_create!
  end
  puts "Data entered in the categories table"
end


#populate Levels
if Level.first.nil?
  puts "Populating levels"
  [
    {i18n_key:'levels.beginner',           number:1,    points_from:1,      points_to:25},
    {i18n_key:'levels.student',            number:2,    points_from:26,     points_to:125},
    {i18n_key:'levels.amateur',            number:3,    points_from:126,    points_to:325},
    {i18n_key:'levels.amateur_technician', number:4,    points_from:326,    points_to:525},
    {i18n_key:'levels.skilled',            number:5,    points_from:526,    points_to:925},
    {i18n_key:'levels.semi_professional',  number:6,    points_from:926,    points_to:1425},
    {i18n_key:'levels.professional',       number:7,    points_from:1426,   points_to:2025},
    {i18n_key:'levels.expert',             number:8,    points_from:2026,   points_to:3025},
    {i18n_key:'levels.veteran',            number:9,    points_from:3026,   points_to:5025},
    {i18n_key:'levels.master',             number:10,   points_from:5026,   points_to:8025},
    {i18n_key:'levels.grand_master',       number:11,   points_from:8026,   points_to:18025},
    {i18n_key:'levels.vip',                number:12,   points_from:18026,  points_to:28025},
    {i18n_key:'levels.superstar',          number:13,   points_from:28026,  points_to:48025},
    {i18n_key:'levels.king',               number:14,   points_from:48026,  points_to:78026}
  ].each {|level|Level.create!(level)}
  puts "Data entered in the levels table"
end

#rating criteria
if RatingCriterium.first.nil?
  puts "Populating Rating criterias"
  [
    {i18n_key:'rating_criterias.composition'},
    {i18n_key:'rating_criterias.criativity'},
    {i18n_key:'rating_criterias.exhibition'},
    {i18n_key:'rating_criterias.distinctness'}
  ].each {|criteria|RatingCriterium.create!(criteria)}
  puts "Data entered in the Rating criterias table"
end


#
#Temporary and should remove after execute
#
UserPoint.all.each do |up|
  up.userx_id = up.user_followed_id unless up.user_followed_id.nil?
  up.userx_id = up.user_follower_id unless up.user_follower_id.nil?
  up.userx_id = up.user_favoriter_id unless up.user_favoriter_id.nil?  
  up.save
end
