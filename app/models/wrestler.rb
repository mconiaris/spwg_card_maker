class Wrestler < ApplicationRecord
	include WrestlerAnalyzer
	include WrestlerPyGenerator
end
