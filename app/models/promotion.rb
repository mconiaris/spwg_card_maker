class Promotion < ApplicationRecord
	has_many :wrestlers

	validates :name, inclusion: { in: %W( AWA Florida Georgia Memphis #{"Mid Atlantic"} #{"Mid South"} Misc None NWA Southwest #{"World Class"} WWF )}
end
