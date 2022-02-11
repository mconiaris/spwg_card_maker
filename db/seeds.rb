# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

Divisions.destroy_all
Promotions.destroy_all
Wrestler.destroy_all

promotions = [ "AWA", "Florida", "Georgia", "Memphis", "Mid Atlantic", 
  "Mid South", "None", "NWA", "Southwest", "World Class", "Women", "WWC", 
  "WWF" ]

 promotions.each { |p| Promotions.create(p) }


divisions = [ "Cruiserweight", "Legend", "Midcard", "None", "Preliminary",
  "Regional Champion", "Super Heavyweight", "Veteran", "Women",
  "World Champion", "Young Star" ]

divisions.each { |d| Division.create(d) }


CSV.foreach(Rails.root.join('lib/seed_file.csv'), headers: true, header_converters: :symbol) do |row|
  
  Wrestler.create(row.to_hash)
end
