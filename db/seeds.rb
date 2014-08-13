# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

country = nil
countries = %W(Brasil)
countries.each do |country|
	country = Country.where(name:country).first_or_create!
end

states = [{name:'Minas Gerais',short_name:'MG',country_id:1},
					{name:'São Paulo',short_name:'SP',country_id:1},
					{name:'Rio de Janeiro',short_name:'RJ',country_id:1}]
states.each do |state|
	State.where(state).first_or_create!
end

categories = %W(Retrato Casamento Street)
categories.each do |category|
	Category.where(description:category).first_or_create!
end
