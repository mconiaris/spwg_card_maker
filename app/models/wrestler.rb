class Wrestler < ApplicationRecord
	include ActiveModel::Validations
	include WrestlerAnalyzer
	include WrestlerPyGenerator
	include WrestlerPrintValues
	include WrestlerStats

	belongs_to :division, optional: true
	belongs_to :promotion, optional: true

	validates :name, :set, :gc02, :gc03, :gc04, :gc05, :gc06, :gc07, :gc08,
		:gc09, :gc10, :gc11, :gc12, :dc02, :dc03, :dc04, :dc05, :dc06, :dc07, 
		:dc08, :dc09, :dc10, :dc11, :dc12, 
		:specialty, :s1, :s2, :s3, :s4, :s5, :s6, 
		:subx, :suby, :tagx, :tagy, :prioritys, :priorityt, 
		:oc02, :oc03, :oc04, :oc05, :oc06, :oc07, :oc08, :oc09, :oc10, :oc11, :oc12, 
		:ro02, :ro03, :ro04, :ro05, :ro06, :ro07, :ro08, :ro09, :ro10, :ro11, :ro12, 
		presence: true

	validates :gc02, :gc03, :gc04, :gc05, :gc06, :gc07, :gc08, :gc09, :gc10, 
		:gc11, :gc12, inclusion: { in: %w(OC OC/TT DC),
		message: "%{value} cannot be entered as a GC value. You only use 'OC', 'DC' or 'OC\/TT'"
	}

	validates :dc02, :dc03, :dc04, :dc05, :dc06, :dc07, :dc08, :dc09, :dc10, 
		:dc11, :dc12, inclusion: { in: %w(A B C Reverse REVERSE),
		message: "%{value} cannot be entered as a DC value. You only use 'A' 'B' 'C' 'Reverse' 'REVERSE'"
	}

	validates :s1, :s2, :s3, :s4, :s5, :s6, 
		wrestler_moves: { valid_move_values: %w{ P/A * (DQ) (XX) }, message: "must end with P/A, *, (DQ), (XX) or a points value of 0-25" }

	validates :oc02, :oc03, :oc04, :oc05, :oc06, :oc07, :oc08, :oc09, :oc10, 
		:oc11, :oc12, 
		wrestler_moves: { valid_move_values: %w{ Ropes ROPES (S) P/A * (DQ) (XX) }, 
		message: "must end with Ropes, ROPES, (S), P/A, *, (DQ), (XX) or a points value of 0-25" }

	validates :ro02, :ro03, :ro04, :ro05, :ro06, :ro07, :ro08, :ro09, 
		:ro10, :ro11, :ro12, wrestler_moves: { valid_move_values: %w{ (S) P/A * (DQ) (XX) N/A }, 
		message: "must end with (S), P/A, *, (DQ), (XX), N/A or a points value of 0-25" }

		validates :oc02, :oc03, :oc04, :oc05, :oc06, :oc07, :oc08, :oc09, :oc10, 
		:oc11, :oc12, :ro02, :ro03, :ro04, :ro05, :ro06, :ro07, :ro08, :ro09, 
		:ro10, :ro11, :ro12, length: { maximum: 32 }

	validates :prioritys, inclusion: { in: %w(1 2 3 4 5 5+ 6), 
		message: "of %{value} is out of range. It can only be 1 to 5 or 5+/6"
	}

	validates :priorityt, inclusion: { in: %w(1 2 3 3+ 4), 
		message: "of %{value} is out of range. It can only be 1 to 3 or 3+/4"
	}

	before_save :set_wrestler_stats

end
