class Wrestler < ApplicationRecord
	include WrestlerAnalyzer
	include WrestlerPyGenerator

	validates :name, presence: true
end
