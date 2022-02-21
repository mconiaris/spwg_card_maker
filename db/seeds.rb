# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
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
  "Mid South", "None", "NWA", "Southwest", "World Class", "Women", "WWC", 
  "WWF" ]

promotions.each { |p| Promotion.create(name: p) }


divisions = [ "Cruiserweight", "Legend", "Midcard", "None", "Preliminary",
  "Regional Champion", "Super Heavyweight", "Veteran", "Women",
  "World Champion", "Young Star" ]

divisions.each { |d| Division.create(name: d) }


CSV.foreach(Rails.root.join('lib/seed_file.csv'), headers: true, header_converters: :symbol) do |row|
  # Convert text from csv into id of object.
  div = row[:division]
  row[:division] = Division.find_by name: div

  prom = row[:promotion]
  row[:promotion] = Promotion.find_by name: prom

  row[:template] = true

  Wrestler.create(row.to_hash)
end

# TODO: Find a more elegant way to generate stats ad DB creation.
@wrestlers = Wrestler.all
@wrestlers.each { |wrestler| stats = wrestler.analyze

  wrestler.tt = stats[:tt_probability]
  wrestler.card_rating = stats[:total_card_rating]
  wrestler.oc_prob = stats[:oc_probability]
  wrestler.total_points = stats[:total_card_points_per_round]
  wrestler.dq_prob = stats[:dq_probability_per_round]
  wrestler.pa_prob = stats[:pa_probability_per_round]
  wrestler.sub_prob = stats[:sub_probability_per_round]
  wrestler.xx_prob = stats[:xx_probability_per_round]
  wrestler.submission = stats[:submission]
  wrestler.tag_team_save = stats[:tag_team_save]

  wrestler.save
 }
