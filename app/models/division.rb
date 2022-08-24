class Division < ApplicationRecord
	has_many :wrestlers

	validates :name, inclusion: { in: %W( Cruiserweight Fake Heavyweight None #{"Super Heavyweight"} Veteran Women #{"Young Star"} )}
end
