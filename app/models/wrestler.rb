class Wrestler < ApplicationRecord
	include WrestlerAnalyzer
	include WrestlerPyGenerator

	validates_with WrestlerValidator

	# TODO: Figure out name and wrestler moves maximum character limit.

	validates :name, :set, :gc02, :gc03, :gc04, :gc05, :gc06, :gc07, :gc08,
		:gc09, :gc10, :gc11, :gc12, :dc02, :dc03, :dc04, :dc05, :dc06, :dc07, 
		:dc08, :dc09, :dc10, :dc11, :dc12, :specialty, :s1, :s2, :s3, :s4, :s5,
		:s6, :subx, :tagx, :prioritys, :priorityt, :oc02, :oc03, :oc04, :oc05, 
		:oc06, :oc07, :oc08, :oc09, :oc10, :oc11, :oc12, :ro02, :ro03, :ro04,
		:ro05, :ro06, :ro07, :ro08, :ro09, :ro10, :ro11, :ro12, 
		presence: true

	validates :gc02, :gc03, :gc04, :gc05, :gc06, :gc07, :gc08, :gc09, :gc10, 
		:gc11, :gc12, inclusion: { in: %w(OC OC/TT DC),
		message: "%{value} cannot be entered as a GC value. You only use 'OC', 'DC' or 'OC\/TT'"
	}

	validates :dc02, :dc03, :dc04, :dc05, :dc06, :dc07, :dc08, :dc09, :dc10, 
		:dc11, :dc12, inclusion: { in: %w(A B C Reverse REVERSE),
		message: "%{value} cannot be entered as a DC value. You only use 'A' 'B' 'C' 'Reverse' 'REVERSE'"
	}

	validates :s1, :s2, :s3, :s4, :s5, :s6, format: { with: /(\d{1,2}|DQ)|(\sP\/A|\*|\s\(XX\))/ }

	validates :s1, :s2, :s3, :s4, :s5, :s6, wrestler_validator: { type: true }

end
