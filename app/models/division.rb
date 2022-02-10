class Division < ApplicationRecord
	has_many :wrestlers

	validates :name, inclusion: { in: %W( Cruiserweight Legend Midcard None Preliminary #{"Regional Champion"} #{"Super Heavyweight"} Veteran Women #{"World Champion"} #{"Young Star"} )}
end
