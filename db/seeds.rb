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
RatingCriterium.update(1,css_class:"composition")
RatingCriterium.update(2,css_class:"criativity")
RatingCriterium.update(3,css_class:"exhibition")
RatingCriterium.update(4,css_class:"distinctness")

plans = [
  {i18n_key:'workshop_plans.basic',          active:true, value:'19.90',  settings:'[{"key":"add_students","value":"1","type":"boolean"},{"key":"limit_students","value":"5","type":"integer"},{"key":"add_materials","value":"0","type":"boolean"},{"key":"limit_materials","value":"0","type":"integer"},{"key":"add_activities","value":"0","type":"boolean"},{"key":"limit_activities","value":"0","type":"integer"}]'},
  {i18n_key:'workshop_plans.premium',        active:true, value:'65.00',  settings:'[{"key":"add_students","value":"1","type":"boolean"},{"key":"limit_students","value":"10","type":"integer"},{"key":"add_materials","value":"1","type":"boolean"},{"key":"limit_materials","value":"5","type":"integer"},{"key":"add_activities","value":"1","type":"boolean"},{"key":"limit_activities","value":"2","type":"integer"}]'},
  {i18n_key:'workshop_plans.professional',   active:true, value:'95.00',  settings:'[{"key":"add_students","value":"1","type":"boolean"},{"key":"limit_students","value":"15","type":"integer"},{"key":"add_materials","value":"1","type":"boolean"},{"key":"limit_materials","value":"10","type":"integer"},{"key":"add_activities","value":"1","type":"boolean"},{"key":"limit_activities","value":"5","type":"integer"}]'},
  {i18n_key:'workshop_plans.enterprise',     active:true, value:'150.00', settings:'[{"key":"add_students","value":"1","type":"boolean"},{"key":"limit_students","value":"25","type":"integer"},{"key":"add_materials","value":"1","type":"boolean"},{"key":"limit_materials","value":"30","type":"integer"},{"key":"add_activities","value":"1","type":"boolean"},{"key":"limit_activities","value":"10","type":"integer"}]'}
].each{|plan| WorkshopPlan.create!(plan)} if WorkshopPlan.first.nil?


portfolio_templates = [
  {i18n_key:'portfolio_templates.free.horizontal_slider',    active:true, price:'0', free:true, settings:'[{"css_class":"portfolio-horizontal-slide"}]'},
  {i18n_key:'portfolio_templates.free.vertical_slider',      active:true, price:'0', free:true, settings:'[{"css_class":"portfolio-vertical-slide"}]'},
  {i18n_key:'portfolio_templates.free.simple_gallery',       active:true, price:'0', free:true, settings:'[{"css_class":"portfolio-simple-gallery"}]'}
].each{|template| PortfolioTemplate.create!(template)} if PortfolioTemplate.first.nil?

# #
# #Temporary and should remove after execute
WorkshopPlan.all.each do |wp|
  wp.settings = wp.settings.gsub("participants","students")
  wp.save
end

# UserProfile.all.each do |up|
#   _name = up.user_name.blank? ? up.full_name.dup : up.user_name
#   _name = _name.gsub(' ','')
#   _name = _name.gsub(/(á|à|ã|â|ä)/, 'a').gsub(/(é|è|ê|ë)/, 'e').gsub(/(í|ì|î|ï)/, 'i').gsub(/(ó|ò|õ|ô|ö)/, 'o').gsub(/(ú|ù|û|ü)/, 'u')
#   _name = _name.gsub(/(Á|À|Ã|Â|Ä)/, 'A').gsub(/(É|È|Ê|Ë)/, 'E').gsub(/(Í|Ì|Î|Ï)/, 'I').gsub(/(Ó|Ò|Õ|Ô|Ö)/, 'O').gsub(/(Ú|Ù|Û|Ü)/, 'U')
#   _name = _name.gsub(/ñ/, 'n').gsub(/Ñ/, 'N')
#   _name = _name.gsub(/ç/, 'c').gsub(/Ç/, 'C')
#   up.user_name = _name.downcase
#   up.save!
# end

# #
# UserPoint.all.each do |up|
#   up.userx_id = up.user_followed_id unless up.user_followed_id.nil?
#   up.userx_id = up.user_follower_id unless up.user_follower_id.nil?
#   up.userx_id = up.user_favoriter_id unless up.user_favoriter_id.nil?  
#   up.save
# end
