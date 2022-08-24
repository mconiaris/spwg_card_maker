# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# This file should contain all the record creation needed to seed the database with its default values.
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

Division.destroy_all
Promotion.destroy_all
Wrestler.destroy_all

promotions = [ "AWA", "Florida", "Georgia", "Memphis", "Mid Atlantic", 
  "Mid South", "Misc", "None", "NWA", "Southwest", "World Class", "WWF" ]

promotions.each { |p| Promotion.create(name: p) }


divisions = [ "Cruiserweight", "Fake", "Heavyweight"
  "Super Heavyweight", "Veteran", "Women", "Young Star" ]

divisions.each { |d| Division.create(name: d) }


CSV.foreach(Rails.root.join('lib/seed_file.csv'), headers: true, header_converters: :symbol) do |row|
  # Convert text from csv into id of object.
  div = row[:division]
  row[:division] = Division.find_by name: div

  prom = row[:promotion]
  row[:promotion] = Promotion.find_by name: prom

  Wrestler.create(row.to_hash)
end
