# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

countries = %W(Brasil)
countries.each do |country|
	Country.where(name:country).first_or_create!
end

categories = %W(Retrato Casamento Street)
categories.each do |category|
	Category.where(description:category)
end
