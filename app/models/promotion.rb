class Promotion < ApplicationRecord
	has_many :wrestlers

	validates :name, inclusion: { in: %W( AWA Florida Georgia Memphis #{Mid Atlantic} #{Mid South} None NWA Southwest #{World Class} Women WWC WWF )}
end
