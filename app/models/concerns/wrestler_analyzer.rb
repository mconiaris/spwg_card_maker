module WrestlerAnalyzer
	# TODO: Export this to it's own Github?
	attr_accessor :statistics
	attr_reader :gc_hash
	attr_reader :oc_hash
	attr_reader :oc_enumerator
	attr_reader :tt_enumerator
	attr_reader :total_card_values
	attr_reader :singles_priority
	attr_reader :tag_team_priority


	attr_reader :tt_roll_probability
	attr_reader :total_card_rating
	attr_reader :oc_roll_probability
	attr_reader :dc_roll_probability
	attr_reader :points_per_round
	attr_reader :points_without_oc_prob
	attr_reader :dq_probability_per_round
	attr_reader :pa_probability_per_round
	attr_reader :sub_probability_per_round
	attr_reader :xx_probability_per_round
	attr_reader :submission_loss_probabilty
	attr_reader :tag_team_save_probabilty

	
	# Constants for Dice Rolls
	TWO_TWELVE = 1
	THREE_ELEVEN = 2
	FOUR_TEN = 3
	FIVE_NINE = 4
	SIX_EIGHT = 5
	SEVEN = 6

	# Constants for DC
	DC_A = 2
	DC_B = 0
	DC_C = 4
	DC_R = 1
	


	module ClassMethods
		
	end


	
	module InstanceMethods

	# ===================
	# GENERATE STATISTICS
	# ===================

	def analyze
		mv_points = move_points

		card_points_per_round = calculate_total_card_rating(mv_points)

		# Add values to wrestler's hash
		self.tt = tt_roll_probability
		self.card_rating = total_card_rating
    self.oc_prob = oc_roll_probability
		self.total_points = points_per_round
		self.card_move_points = points_without_oc_prob
		self.dq_prob = dq_probability_per_round
		self.pa_prob = pa_probability_per_round
		self.sub_prob = sub_probability_per_round
		self.xx_prob = xx_probability_per_round
		self.submission = submission_loss_probabilty
		self.tag_team_save = tag_team_save_probabilty
		# Check for Problems in :set attribute of hash.
		if attributes["set"] == nil
			self.set = 'Special'
		else
			self.set = attributes["set"]
		end
	end



	# ======================
	# MOVE VALUES TO NUMBERS
	# ======================
	
	def move_points

		# Various methods will take text values and convert 
		# them into numbers so that statistics can be 
		# generated. This hash is the container for those 
		# numbers.
		points = Hash.new

		calculate_oc_roll_probability

		@dc_roll_probability = calculate_gc_dc_roll_probability(oc_enumerator)

		# Calculate TT Roll in GC
		@tt_enumerator = calculate_tt_enumerator(gc_hash)
		@tt_roll_probability = calculate_gc_tt_roll_probability(tt_enumerator)

		
		# ==================================
		# MAKE POINTS HASH WITH ALL 0 VALUES
		# ==================================
		make_blank_points_hash(points, "dc", "points")

		points[:Reverse] = 0
		points[:Specialty_Roll_Probability_in_OC] = 0

		# Creating of Blank Specialty Hash Is Unique
 		for i in 1..6 do
			s_points = "s#{i}_points"
			points[s_points.to_sym] = 0
			i += 1
		end

 		points[:s_roll_prob_dq] = 0
		points[:s_roll_prob_pa] = 0
		points[:s_roll_prob_sub] = 0
		points[:s_roll_prob_xx] = 0

		make_blank_points_hash(points, "oc", "points")
		make_blank_points_hash(points, "oc", "dq")
		make_blank_points_hash(points, "oc", "pa")
		make_blank_points_hash(points, "oc", "sub")
		make_blank_points_hash(points, "oc", "xx")
		
 		points[:OC_Ropes_Roll_Probability] = 0
 		points[:Ropes_S_Roll_Probability] = 0
 		
 		make_blank_points_hash(points, "ro", "points")
		make_blank_points_hash(points, "ro", "dq")
		make_blank_points_hash(points, "ro", "pa")
		make_blank_points_hash(points, "ro", "sub")
		make_blank_points_hash(points, "ro", "xx")

		points[:sub_numerator] = 0
		points[:tag_save_numerator] = 0

		# =========================
		# ADD VALUES TO POINTS HASH
		# =========================

		# Determine Points for DC Rolls
		dc_hash = attributes.select { |k,v| k.to_s.include?('dc') }
		dc_hash.each { | k,v|
			if v == "A"
				points["#{k}_points".to_sym] = DC_A
			elsif v == "C"
				points["#{k}_points".to_sym] = DC_C
			else
				points["#{k}_points".to_sym] = DC_B
			end
		}

		# Calculate Reverse Roll in DC
		reverse_roll = 0
		r_hash = attributes.select { |k,v| k.to_s.include?('dc') && v.downcase.include?('reverse') }
		points[:Reverse] = prob_points(r_hash)

		# Determine (S) Points
		points[:s1_points] = attributes["s1"].split[0].to_i
 		points[:s2_points] = attributes["s2"].split[0].to_i
 		points[:s3_points] = attributes["s3"].split[0].to_i
 		points[:s4_points] = attributes["s4"].split[0].to_i
 		points[:s5_points] = attributes["s5"].split[0].to_i
 		points[:s6_points] = attributes["s6"].split[0].to_i

 		o_moves = attributes.select { |k,v| k.to_s.include?('oc') }
 		o_moves.delete("oc_prob")
 		o_moves.each { |k,v|
 			key = "#{k}_points".to_sym
 			m = remove_move(v)
 			points[key] = m
 		}

 		r_moves = attributes.select { |k,v| k[0..1].to_s.include?('ro') }
 		r_moves.each { |k,v|
 			key = "#{k}_points".to_sym
 			m = remove_move(v)
 			points[key] = m
 		}

 		# Get Specialty Roll Numerator in OC
 		s = attributes.select { |k,v| k.to_s.include?('oc') }
 		s.delete("oc_prob")
 		s = s.select { |k,v| v.include?('(S)') }
 		points[:Specialty_Roll_Enumerator_in_OC] = prob_points(s)
 		points[:Specialty_Roll_Probability_in_OC] = return_rational(points[:Specialty_Roll_Enumerator_in_OC])

 		# Get Specialty Roll Probability-DQ (x/6)
		spec_array = [ attributes["s1"], attributes["s2"], attributes["s3"],
			attributes["s4"], attributes["s5"], attributes["s6"] ]
 		points[:s_roll_prob_dq] = get_s_extra_values(spec_array, '(DQ)')
 		points[:s_roll_prob_pa] = get_s_extra_values(spec_array, 'P/A')
		points[:s_roll_prob_sub] = get_s_extra_values(spec_array, '*')
		points[:s_roll_prob_xx] = get_s_extra_values(spec_array, '(xx)')
 			
		# Find DQ, P/A, * and XX Values in OC and Ropes
 		dq_hash = create_value_hash(attributes, "(DQ)")
 		pa_hash = create_value_hash(attributes, "P/A")
 		sub_hash = create_value_hash(attributes, "*")
 		lc_xx_hash = create_value_hash(attributes, "(xx)")
 		uc_xx_hash = create_value_hash(attributes, "(XX)")
 		xx_hash = lc_xx_hash.merge(uc_xx_hash)

 		add_values_to_points_hash(points, dq_hash, "dq")
 		add_values_to_points_hash(points, pa_hash, "pa")
 		add_values_to_points_hash(points, sub_hash, "sub")
 		add_values_to_points_hash(points, xx_hash, "xx")

 		# Determine Ropes Roll Enumerator
 		oc_ropes_hash = attributes.select { |k,v| v == 'Ropes' }

 		points[:OC_Ropes_Roll_Probability] = prob_points(oc_ropes_hash)

 		# Determine Enumerator of (S) rolls in Ropes
 		ropes_s_hash = attributes.select { |k,v| k[0..1].include?("ro") && v.include?('(S)') }
 		points[:Ropes_S_Roll_Probability] = prob_points(ropes_s_hash)

 		@singles_priority = attributes["prioritys"].to_i
 		@tag_team_priority = attributes["priorityt"].to_i

 		points[:sub_numerator] = sub_tag_numerator(attributes["subx"], attributes["suby"])
 		points[:tag_save_numerator] = sub_tag_numerator(attributes["tagx"], attributes["tagy"])

 		@submission_loss_probabilty = return_rational(points[:sub_numerator]).to_f
 		@tag_team_save_probabilty = return_rational(points[:tag_save_numerator]).to_f

		return points
	end


	def calculate_oc_roll_probability
		@gc_hash = attributes.select { |k,v| k.to_s.include?('gc') }
		@oc_hash = gc_hash.select { |k,v| v.include?('OC') }

		# Calculate OC count to calculate probablity.
		@oc_enumerator = prob_points(oc_hash)

		@oc_roll_probability = (return_rational(oc_enumerator).to_f)
	end


	private


	# ==============================
	# METHODS TO GENERATE STATISTICS
	# ==============================

	def symbol_to_integer(key)
		key[-2..-1].to_i
	end


	# 2d6 roll so that it can be used to calculate the
	# probabilty of rolls for GC, OC & DC.
	def calculate_probability(key)

		k = key

		case k
		when 2
			return TWO_TWELVE
		when 3
			return THREE_ELEVEN
		when 4
			return FOUR_TEN
		when 5
			return FIVE_NINE
		when 6
			return SIX_EIGHT
		when 7
			return SEVEN
		when 8
			return SIX_EIGHT
		when 9
			return FIVE_NINE
		when 10
			return FOUR_TEN
		when 11
			return THREE_ELEVEN
		when 12
			return TWO_TWELVE
		else
			return 0
		end
	end
	

	def remove_move(move)

		m = move.split

		if m.size == 1
			return 0
		elsif m.last == "(S)" || m.last == "Ropes"
			return 0
		elsif m.last == "(DQ)"
			return 5
		elsif m.last.to_i == 0
			return m[m.length-2].to_i
		elsif m.last.to_i != 0
			return m.last.to_i
		else
			return "Error"
		end
	end


	def prob_points(move)
		# Calculate OC count to calculate probablity.
		count = 0
		move.each_key { |k|
			count += calculate_probability(symbol_to_integer(k))
		}
		return count
	end


	# Takes in Wrestler Values Array of Sub values, 
	# converts them to integers and then a range and
	# determines the probabillity of a submission.
	def sub_tag_numerator(x, y)

		values = []

		if x == nil
			x = 0
		end

		if y == nil
			y = 0
		end

		if x != 0
			values.push(x)
		end

		if y != 0
			values.push(y)
		end

		num = 0

		if values.size == 2
			s = Range.new(values[0].to_i, values[1].to_i)
			s.each { |x|
				num += calculate_probability(x)
			}
		elsif values.size == 1
			x = values[0].to_i
			num += calculate_probability(x)
		else
			puts "Sub or Tag numbers are out of range."				
		end
		return num
	end

	# Isolates P/A, DQ, xx or * results in Specialty
	# Card and returns the number of them.
	def get_s_extra_values(moves, value)
		h = moves.select { |v| v.include?(value) }
		return h.size
	end

	
	# Takes in all of the Wrestler moves and returns a
	# hash of the moves that contain either a P/A, DQ,
	# * or xx that is passed to it.
	def create_value_hash(moves, value)
		m = moves.select { |k,v| k.include?("oc")}

		m.delete("oc_prob")
		r = moves.select { |k,v| k[0..1].include?("ro")}
		m = m.merge(r)
		return m.select { |k,v| v.include?(value)}
	end


	# Check Sub & Tag Inputs for Nil values and remove them.
	def revmove_nil(x)
		if x == nil
			x = 0			
		end
	end

	def make_blank_points_hash(move_hash, card, move)
		for i in 2..12 do
			move_key = "#{card}%02d_#{move}" % i
			move_hash[move_key.to_sym] = 0
			i += 1
		end
		move_hash
	end

	def add_values_to_points_hash(points_hash, move_hash, move)
		move_hash.each { |k,v| 
	 			key = k.to_s + "_#{move}"
	 			points_hash[key.to_sym] = 1
	 		}
		points_hash
	end


	# ==========================
	# GENERATE TOTAL CARD RATING
	# ==========================

	# total_card_rating
	def calculate_total_card_rating(move_points)
		@points_per_round = calculate_card_points_per_round(move_points)
		@points_without_oc_prob = calculate_points_without_oc_prob(points_per_round, oc_roll_probability)
		@dq_probability_per_round = calculate_dq_probability_per_round(move_points)
		@pa_probability_per_round = calculate_pa_probability_per_round(move_points)
		@sub_probability_per_round = calculate_sub_probability_per_round(move_points)
		@xx_probability_per_round = calculate_xx_probability_per_round(move_points)
		
		# Double P/A per round and divide XX per round for total card value
		# to increase relative value of pin attempts.
		@total_card_values = (points_per_round * 
			oc_roll_probability) +
			(dq_probability_per_round * 5) + 
			(pa_probability_per_round * 20) +
			(sub_probability_per_round * 10) + 
			(xx_probability_per_round * 5)

		@total_card_rating = total_card_values + 
			singles_priority - (submission_loss_probabilty * 10)

		return total_card_rating
	end


	# TODO: Refactor methods below into one method with
	# less information being passed into it.
	# card_points_per_round
	def calculate_card_points_per_round(wrestler)

		oc_points_per_round_total = 
			calculate_oc_points_per_round_total(wrestler)
		# DC points per round total
		dc_points_per_round_total = 
			calculate_dc_points_per_round_total(wrestler, oc_points_per_round_total)

		return dc_points_per_round_total + 
			oc_points_per_round_total
	end

	def calculate_points_without_oc_prob(total_points, oc_prob)
		@calculate_points_without_oc_prob = total_points / oc_prob
	end

	# dq_probability_per_round
	def calculate_dq_probability_per_round(wrestler)
		oc_dq_per_round_total = 
			calculate_oc_dq_per_round_total(wrestler)

		return oc_dq_per_round_total
	end


	# pa_probability_per_round
	def calculate_pa_probability_per_round(wrestler)
		oc_pa_per_round_total = 
			calculate_oc_pa_per_round_total(wrestler)

		return oc_pa_per_round_total
	end


	# sub_probability_per_round
	def calculate_sub_probability_per_round(wrestler)
		oc_sub_per_round_total = 
			calculate_oc_sub_per_round_total(wrestler)

		return oc_sub_per_round_total
	end


	# xx_probability_per_round
	def calculate_xx_probability_per_round(wrestler)
		oc_xx_per_round_total = 
			calculate_oc_xx_per_round_total(wrestler)

		return oc_xx_per_round_total
	end


	# =========
	# UTILITIES
	# =========	

	# Takes in OC enumerator and divides it by 36
	def return_rational(numerator)
		numerator/36.to_r
	end

	def remove_attribute_from_key(k)
		k = k[0..3].to_sym
	end

	def return_attribute_hash(h, attribute)
		dq_hash = h.select { |k,v| k.to_s.include?(attribute) }
	end


	# ============
	# GENERAL CARD
	# ============

	# Takes in probability of an OC roll and uses it to
	# determine the probability of a DC roll.
	def calculate_gc_dc_roll_probability(oc_roll_probability)
		return 36/36.to_r - return_rational(oc_roll_probability)
	end


	def calculate_tt_enumerator(wrestler_hash)

		h = wrestler_hash.select { |k,v| v == 'OC/TT' }
		prob = 0

		h.each_key {
			|k| prob += calculate_probability(symbol_to_integer(k))
		}

		return prob
	end


	# Takes in wrestler card hash and searches for OC/TT
	# rolls and then calculates their probability.
	def calculate_gc_tt_roll_probability(tt_enum)
		return_rational(tt_enum)
	end


	# ==============
	# DEFENSIVE CARD
	# ==============
	# Takes in wrestler card hash Reverse probabilty
	# and multiplies it by the probability of rolling
	# the DC card.
	def calculate_dc_points_per_round_total(wrestler, oc_sub_total)
		# DC Points
		dc_hash = get_dc_card_hash(wrestler)
		
		dc_points_per_round_subtotal = 
			calculate_dc_points_per_round_subtotal(dc_hash)

		# TODO: replace hard coded number with
		# total points variable
		rev_prob = return_rational(wrestler[:Reverse])

		reverse_points_per_round = calculate_reverse_points(wrestler, oc_sub_total)
		# DC points per round total
		dc_points_per_round_total = 
			dc_points_per_round_subtotal +
			reverse_points_per_round

		return dc_points_per_round_total
	end

	def get_dc_card_hash(wrestler)
		h = wrestler.select { |k,v| k.to_s.include?("dc") }
		h.delete(:DC)
		return h
	end


	def calculate_reverse_round_probability(wrestler_hash, gc_dc_roll_probability)
		prob = return_rational(wrestler_hash[:Reverse])

		return prob * gc_dc_roll_probability
	end


	# Multiplies DC roll point by probabiliy of rolling it.
	def calculate_dc_points_per_round_subtotal(hash)
			
			# Return sum of points per roll in DC
			x = 0
			hash.each { |k,v|
				k = remove_attribute_from_key(k)
				x += v.to_f * calculate_probability(symbol_to_integer(k))/36.to_f
			}

			# Return Points per DC Roll * DC Roll Probability
			return x
	end


	# DC Roll Probability * Reverse Roll in DC Probabiity *
	# Total OC Points Per Round
	def calculate_reverse_points(wrestler, oc_sub_total)
		reverse_points = dc_roll_probability * 
			return_rational(wrestler[:Reverse]) * oc_sub_total

		return reverse_points
	end




	# ==============
	# OFFENSIVE CARD
	# ==============

	# OC Points Subtotal + Ropes + Speci
	def calculate_oc_points_per_round_total(wrestler)

		oc_points_subtotal = 
			calculate_oc_points_subtotal(wrestler)

		oc_specialty_points_per_round = 
			calculate_oc_specialty_points_per_round(wrestler)

		ropes_points_total = 
			calculate_ropes_points_total(wrestler)

		oc_points_per_round_total = oc_points_subtotal +
			oc_specialty_points_per_round + ropes_points_total
		
		return oc_points_per_round_total
	end

	def calculate_oc_dq_per_round_total(wrestler)
		oc_dq_subtotal = 
			calculate_oc_dq_subtotal(wrestler)

		oc_specialty_dq_per_round = 
			calculate_oc_specialty_dq_per_round(wrestler)

		ropes_dq_total = 
			calculate_ropes_dq_total(wrestler)

		oc_dq_per_round_total = oc_dq_subtotal +
			oc_specialty_dq_per_round + ropes_dq_total
		
		return oc_dq_per_round_total
	end

	def calculate_oc_pa_per_round_total(wrestler)
		oc_pa_subtotal = 
			calculate_oc_pa_subtotal(wrestler)
		oc_specialty_pa_per_round = 
			calculate_oc_specialty_pa_per_round(wrestler)

		ropes_pa_total = 
			calculate_ropes_pa_total(wrestler)
	
		oc_pa_per_round_total = oc_pa_subtotal +
			oc_specialty_pa_per_round + ropes_pa_total

		return oc_pa_per_round_total
	end


	def calculate_oc_sub_per_round_total(wrestler)
		oc_sub_subtotal = 
			calculate_oc_sub_subtotal(wrestler)
		oc_specialty_sub_per_round = 
			calculate_oc_specialty_sub_per_round(wrestler)

		ropes_sub_total = 
			calculate_ropes_sub_total(wrestler)


		oc_sub_per_round_total = oc_sub_subtotal +
			oc_specialty_sub_per_round + ropes_sub_total
		return oc_sub_per_round_total
	end

	def calculate_oc_xx_per_round_total(wrestler)
		oc_xx_subtotal = 
			calculate_oc_xx_subtotal(wrestler)

		oc_specialty_xx_per_round = 
			calculate_oc_specialty_xx_per_round(wrestler)

		ropes_xx_total = 
			calculate_ropes_xx_total(wrestler)

		oc_xx_per_round_total = oc_xx_subtotal +
			oc_specialty_xx_per_round + ropes_xx_total
		return oc_xx_per_round_total
	end


	def get_oc_hash(wrestler)
		h = wrestler.select { |k,v| k.to_s.include?("oc") }
		return h
	end


	# specialty points average (total / 6) * 
	# oc_roll_probility * (S) probability
	def calculate_oc_specialty_points_per_round(wrestler)

		specialty_points_average = 
			calculate_specialty_points_average(wrestler)

		oc_specialty_points_per_round = 
			calculate_oc_specialty_per_round(
				wrestler, specialty_points_average)

		return oc_specialty_points_per_round
	end

	def calculate_oc_specialty_dq_per_round(wrestler)
		specialty_dq_average = 
			calculate_specialty_dq_average(wrestler)
	end

	def calculate_oc_specialty_pa_per_round(wrestler)
		specialty_pa_average = 
			calculate_specialty_pa_average(wrestler)

		oc_specialty_pa_per_round = 
			calculate_oc_specialty_per_round(
				wrestler, specialty_pa_average)
	end

	def calculate_oc_specialty_sub_per_round(wrestler)
		specialty_sub_average = 
			calculate_specialty_sub_average(wrestler)

		oc_specialty_sub_per_round = 
			calculate_oc_specialty_per_round(
				wrestler, specialty_sub_average)
	end


	def calculate_oc_specialty_xx_per_round(wrestler)
		specialty_xx_average = 
			calculate_specialty_xx_average(wrestler)

		oc_specialty_xx_per_round = 
			calculate_oc_specialty_per_round(
				wrestler, specialty_xx_average)
	end


	# OC points per roll total not including (S) or Ropes
	def calculate_oc_points_subtotal(move_points)

		oc_hash = get_oc_hash(move_points)

		oc_points_hash = oc_hash.select { |k,v| k.to_s.include?("points") }
		
		return calculate_oc_subtotal(oc_points_hash)
	end

	def calculate_oc_dq_subtotal(wrestler)

		dq_hash = return_attribute_hash(wrestler, "_dq")
		oc_dq_hash = return_attribute_hash(dq_hash, "oc")

		return calculate_dq_subtotal(oc_dq_hash)
	end

	def calculate_oc_pa_subtotal(wrestler)

		pa_hash = return_attribute_hash(wrestler, "_pa")
		oc_pa_hash = return_attribute_hash(pa_hash, "oc")

		pa_subtotal = calculate_pa_subtotal(oc_pa_hash)

		return pa_subtotal
	end

	def calculate_oc_sub_subtotal(wrestler)

		sub_hash = return_attribute_hash(wrestler, "_sub")
		sub_hash.delete(:s_roll_prob_sub)

		oc_sub_hash = return_attribute_hash(sub_hash, "oc")

		sub_subtotal = calculate_sub_subtotal(oc_sub_hash)

		return sub_subtotal
	end

	def calculate_oc_xx_subtotal(wrestler)

		xx_hash = return_attribute_hash(wrestler, "_xx")

		oc_xx_hash = return_attribute_hash(xx_hash, "oc")

		xx_subtotal = calculate_xx_subtotal(oc_xx_hash)

		return xx_subtotal
	end


	# Takes in points, P/A, sub, etc. and 
	# Calculates the probability in the (S) card.
	def calculate_oc_specialty_per_round(
		wrestler, attribute)
		
		specialty_roll_prob = 
			wrestler[:Specialty_Roll_Probability_in_OC]

		oc_specialty_points_per_round = 
			attribute * specialty_roll_prob 

		return oc_specialty_points_per_round
	end

	# TODO: Delete oc from parameter list and use getter
	# Takes in points, P/A, sub, etc. and 
	# Calculates the probability in the OC card.
	def calculate_oc_subtotal(wrestler)
		
		# Sum up points per roll * probability
		oc_points = 0
		wrestler.each { |k,v| 
			k = remove_attribute_from_key(k)
			prob = return_rational(calculate_probability(symbol_to_integer(k))).to_f
			oc_points += v * prob
		}

		oc_points_subtotal = oc_points
		return oc_points_subtotal
	end

	# TODO: Delete oc from parameter list and use getter
	def calculate_dq_subtotal(wrestler)
		# Sum up points per roll * probability
		dq_points = 0
		wrestler.each { |k,v| 
			k = remove_attribute_from_key(k)
			prob = return_rational(calculate_probability(symbol_to_integer(k))).to_f
			dq_points += v * prob
		}

		dq_points_subtotal = dq_points
		return dq_points_subtotal
	end

	# TODO: Delete oc from parameter list and use getter
	def calculate_pa_subtotal(wrestler)
		# Sum up points per roll * probability
		pa_points = 0
		wrestler.each { |k,v| 
			k = remove_attribute_from_key(k)
			prob = return_rational(calculate_probability(symbol_to_integer(k))).to_f
			pa_points += v * prob
		}

		pa_points_subtotal = pa_points
		return pa_points_subtotal
	end

	# TODO: Delete oc from parameter list and use getter
	def calculate_sub_subtotal(wrestler)
		# Sum up points per roll * probability
		sub_points = 0
		wrestler.each { |k,v| 
			k = remove_attribute_from_key(k)
			prob = return_rational(calculate_probability(symbol_to_integer(k))).to_f
			sub_points += v * prob
		}

		sub_points_subtotal = sub_points
		return sub_points_subtotal
	end

	# TODO: Delete oc from parameter list and use getter
	def calculate_xx_subtotal(wrestler)
		# Sum up points per roll * probability
		xx_points = 0
		wrestler.each { |k,v| 
			k = remove_attribute_from_key(k)
			prob = return_rational(calculate_probability(symbol_to_integer(k))).to_f
			xx_points += v * prob
		}

		xx_points_subtotal = xx_points
		return xx_points_subtotal
	end


	# ==========
	# ROPES CARD
	# ==========
	# Takes in the Ropes Points per GC Roll total and
	# multiplies it by the probablilty of rollinc OC and
	# then multip;ies it by the probability of rolling 
	# Ropes

	# Ropes Points Subtotal without (S)
	# 	points * oc_prob * ropes_prob
	def calculate_ropes_points_total(wrestler)

		ropes_specialty_points = 
			calculate_ropes_specialty_points(wrestler)
		ropes_points_per_roll_subtotal = 
			calculate_ropes_points_per_roll_total(wrestler)

		ropes_total = ropes_points_per_roll_subtotal + 
				ropes_specialty_points

		return ropes_total
	end

	def calculate_ropes_dq_total(wrestler)
		ropes_specialty_dq = 
			calculate_ropes_specialty_dq(wrestler)
		ropes_dq_per_roll_subtotal = 
			calculate_ropes_dq_per_roll_total(wrestler)

		ropes_dq_total = ropes_dq_per_roll_subtotal + 
				ropes_specialty_dq

		return ropes_dq_total
	end

	def calculate_ropes_pa_total(wrestler)
		
		ropes_specialty_pa = 
			calculate_ropes_specialty_pa(wrestler)
		ropes_pa_per_roll_subtotal = 
			calculate_ropes_pa_per_roll_total(wrestler)

		ropes_pa_total = ropes_pa_per_roll_subtotal + 
				ropes_specialty_pa

		return ropes_pa_total
	end

	def calculate_ropes_sub_total(wrestler)
		
		ropes_specialty_sub = 
			calculate_ropes_specialty_sub(wrestler)
		ropes_sub_per_roll_subtotal = 
			calculate_ropes_sub_per_roll_total(wrestler)

		ropes_sub_total = ropes_sub_per_roll_subtotal + 
				ropes_specialty_sub
	end


	def calculate_ropes_xx_total(wrestler)
		ropes_specialty_xx = 
			calculate_ropes_specialty_xx(wrestler)
		ropes_xx_per_roll_subtotal = 
			calculate_ropes_xx_per_roll_total(wrestler)

		ropes_xx_total = ropes_xx_per_roll_subtotal + 
				ropes_specialty_xx
	end


	def calculate_ropes_points_per_roll_total(wrestler)
		r_hash = get_ropes_hash(wrestler)
		r_points_hash = r_hash.select { |k,v| k.to_s.include?("_points") }

		calculate_ropes_per_roll_total(wrestler, r_points_hash)
	end

	def calculate_ropes_dq_per_roll_total(wrestler)

		r_hash = get_ropes_hash(wrestler)
		r_dq_hash = r_hash.select { |k,v| k.to_s.include?("_dq") }
		r_dq_hash.delete(:s_roll_prob_dq)

		calculate_ropes_per_roll_total(wrestler, r_dq_hash)
	end

	def calculate_ropes_pa_per_roll_total(wrestler)
		r_hash = get_ropes_hash(wrestler)
		r_pa_hash = r_hash.select { |k,v| k.to_s.include?("_pa") }
		r_pa_hash.delete(:s_roll_prob_pa)

		calculate_ropes_per_roll_total(wrestler, r_pa_hash)
	end


	def calculate_ropes_sub_per_roll_total(wrestler)
		r_hash = get_ropes_hash(wrestler)
		r_sub_hash = r_hash.select { |k,v| k.to_s.include?("_sub") }
		r_sub_hash.delete(:s_roll_prob_sub)

		calculate_ropes_per_roll_total(wrestler, r_sub_hash)
	end


	def calculate_ropes_xx_per_roll_total(wrestler)

		r_hash = get_ropes_hash(wrestler)
		r_xx_hash = r_hash.select { |k,v| k.to_s.include?("_xx") }
		r_xx_hash.delete(:s_roll_prob_xx)

		calculate_ropes_per_roll_total(wrestler, r_xx_hash)
	end


	def calculate_ropes_per_roll_total(wrestler, attribute)
		
		r_points = 0
		attribute.each { |k,v| 
			k = remove_attribute_from_key(k)
			prob = return_rational(calculate_probability(symbol_to_integer(k))).to_f
			r_points += v * prob
		}

		ropes_roll_prob = return_rational(wrestler[:OC_Ropes_Roll_Probability]).to_f

		r_points_subtotal = r_points * 
			ropes_roll_prob

		return r_points_subtotal
	end


	def calculate_ropes_specialty_points(wrestler)

		ropes_roll_prob = return_rational(wrestler[:OC_Ropes_Roll_Probability])
		ropes_s_roll_prob = return_rational(wrestler[:Ropes_S_Roll_Probability])
		s_points_av = calculate_specialty_points_average(wrestler)
		
		s_points = ropes_roll_prob.to_f * 
			ropes_s_roll_prob * s_points_av

		return s_points
	end

	def calculate_ropes_specialty_dq(wrestler)

		ropes_roll_prob = return_rational(wrestler[:OC_Ropes_Roll_Probability])
		ropes_s_roll_prob = return_rational(wrestler[:Ropes_S_Roll_Probability])
		s_dq_av = calculate_specialty_dq_average(wrestler)
		
		s_dq = ropes_roll_prob.to_f * 
			ropes_s_roll_prob * s_dq_av

		return s_dq
	end


	def calculate_ropes_specialty_pa(wrestler)
		ropes_roll_prob = return_rational(wrestler[:OC_Ropes_Roll_Probability])
		ropes_s_roll_prob = return_rational(wrestler[:Ropes_S_Roll_Probability])
		s_pa_av = calculate_specialty_pa_average(wrestler)
		
		s_pa = ropes_roll_prob.to_f * 
			ropes_s_roll_prob * s_pa_av

		return s_pa
	end


	def calculate_ropes_specialty_sub(wrestler)
		ropes_roll_prob = return_rational(wrestler[:OC_Ropes_Roll_Probability])
		ropes_s_roll_prob = return_rational(wrestler[:Ropes_S_Roll_Probability])
		s_sub_av = calculate_specialty_sub_average(wrestler)
		
		s_sub = ropes_roll_prob.to_f * 
			ropes_s_roll_prob * s_sub_av
		return s_sub
	end


	def calculate_ropes_specialty_xx(wrestler)
		ropes_roll_prob = return_rational(wrestler[:OC_Ropes_Roll_Probability])
		ropes_s_roll_prob = return_rational(wrestler[:Ropes_S_Roll_Probability])
		s_xx_av = calculate_specialty_xx_average(wrestler)
		
		s_xx = ropes_roll_prob.to_f * 
			ropes_s_roll_prob * s_xx_av
		return s_xx
	end


	def get_ropes_hash(wrestler)
		h = wrestler.select { |k,v| k.to_s.include?("ro") }
		
		return h
	end






	# ==============
	# SPECIALTY CARD
	# ==============

	# Take in (S) hash, isolate points, add up points
	# and then divide by 6.
	def calculate_specialty_points_average(wrestler)

		s_hash = get_specialty_hash(wrestler)
		s_points_hash = s_hash.select { |k,v| k.to_s.include?("_points")}

		s_points = 0

		s_points_hash.each { |k,v| 
			s_points += v

		}
		return s_points/6.to_f
	end

	# TODO: Factor out wrestler parameter
	def calculate_specialty_dq_average(wrestler)

		s_hash = get_specialty_hash(attributes)

		s_dq_hash = s_hash.select { |k,v| v.include?("(DQ)")}

		s_dq = s_dq_hash.size

		if s_dq == 0
			return 0
		end

		return s_dq/6.to_f
	end


	# TODO: Factor out wrestler parameter
	def calculate_specialty_pa_average(wrestler)

		s_hash = get_specialty_hash(attributes)
		s_pa_hash = s_hash.select { |k,v| v.include?("P/A")}

		s_pa = s_pa_hash.size

		if s_pa == 0
			p_a_av = 0
		else
			p_a_av = s_pa/6.to_f
		end

		return p_a_av
	end

	# TODO: Factor out wrestler parameter
	def calculate_specialty_sub_average(wrestler)

		s_hash = get_specialty_hash(attributes)
		s_sub_hash = s_hash.select { |k,v| v.include?("*")}

		s_sub = s_sub_hash.size

		if s_sub == 0
			av = 0
		else
			av = s_sub/6.to_f
		end

		return av
	end


	def calculate_specialty_xx_average(wrestler)
		s_hash = get_specialty_hash(attributes)

		s_xx_hash = s_hash.select { |k,v| v.include?("(XX)")}

		s_xx = s_xx_hash.size

		if s_xx == 0
			av = 0
		else
			av = s_xx/6.to_f
		end

		return av
	end


	def get_specialty_hash(wrestler)
		wrestler.select { |k,v| k.to_s =~ /s\d/ }
	end

end

	
	def self.included(receiver)
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
	end
end