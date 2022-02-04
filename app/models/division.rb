class Division < ApplicationRecord
	has_many :wrestlers

	validates :name, inclusion { in: %w( Cruiserweight Legend Midcard Preliminary Regional Super Veteran Women World Young )}
end
