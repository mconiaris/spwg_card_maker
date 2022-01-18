module WrestlerPyGenerator
	attr_accessor :card


	module ClassMethods
		
	end


	
	module InstanceMethods

		def print_card_text
			"This is a card test."
		end

		def print_card
			wrestler_card = "# -*- coding: utf-8 -*-\n" +
			"from data.globalConstants import *\n" +
			"# #{self[:name]}\n" +
			"name = '#{self[:name]}'\n" +
			"\n" +
			"# General Card Definitions: \n" +
			"#    1000 = OC\n" +
			"#    1001 = OC/TT\n" +
			"#    1002 = DC\n" +
			"GeneralCard = #{make_general_card}\n" +
			"\n" +
			"# Offensive Card Definitions:\n" +
			"#    1003 = Pin attempt move (P/A)\n" +
			"#    1004 = Submission Move (*)\n" +
			"#    1005 = Specialty Move (S)\n" +
			"#    1006 = Disqualification Move (DQ)\n" +
			"#    1008 = Regular Offensive Move\n" +
			"#    1009 = Grudge Match Move (XX)\n" +
			"#    1010 = Ropes Move (ROPES)\n" +
			"OffensiveCard = \\\n" +
			"#{make_offensive_card}" +
			"# Defensive Card Definitions:\n" +
			"#    0 = B - No points on defense\n" +
			"#    2 = A - 2 points on defense\n" +
			"#    4 = C - 4 points on defense and neutralize offensive move\n" +
			"#    5 = Reverse - Reverse offensive move\n" +
			"#{make_defensive_card}" +
			"\n" +
			"# Specialty Card Definitions:\n" +
			"#    1003 = Pin attempt move (P/A)\n" +
			"#    1004 = Submission Move (*)\n" +
			"#    1005 = Specialty Move (S)\n" +
			"#    1006 = Disqualification Move (DQ)\n" +
			"#{make_specialty_card}" +
			"# Ropes Card Definitions:\n" +
			"#    1003 = Pin attempt move (P/A)\n" +
			"#    1004 = Submission Move (*)\n" +
			"#    1005 = Specialty Move (S)\n" +
			"#    1006 = Disqualification Move (DQ)\n" +
			"#    1008 = Regular Offensive Move\n" +
			"#    1009 = Grudge Match Move (XX)\n" +
			"#    1010 = Ropes Move (ROPES)\n" +
			"#    1014 = No Action (NA)\n" +
			"Ropes = \\\n" +
			"#{make_ropes_card}" +
			"\n" + 
			"Sub = (#{check_sub_tag_value(self[:subx])}, #{check_sub_tag_value(self[:suby])})\n" +
			"TagTeam = (#{check_sub_tag_value(self[:tagx])}, #{check_sub_tag_value(self[:tagy])})\n" +
			"Priority = (#{self[:prioritys]}, #{self[:priorityt]})\n" +
			"nameSet = \"#{self[:set]}\""
		end

		private

		def make_general_card
			gc = [ self[:gc02], self[:gc03], self[:gc04], self[:gc05], 
				self[:gc06], self[:gc07], self[:gc08], self[:gc09], self[:gc10], 
				self[:gc11], self[:gc12] ]

			gc.map! do |item|
				if item == "OC"
					item = 1000
				elsif item == "OC/TT"
					item = 1001
				else item == "DC"
					item = 1002
				end
			end
		end

		def make_offensive_card

			oc_move_array = Array.new

			oc_points_hash = move_points.select { |k,v| k.to_s[0..1] == "oc" }
			oc_moves_hash = attributes.select { |k,v| k[0..1] == "oc" }
			oc_moves_hash.delete("oc_prob")


			oc_moves_hash.each { |k,v|
				array_key = (k[2..3].to_i) - 2

				if v.underscore == "ropes"
					oc_move_array[array_key] = "{   'MOVE_NAME': 'ROPES', 'MOVE_TYPE': 1010}"
				elsif v.underscore.include?("(s)")
					move = v.underscore.gsub!("(s)","").upcase.strip
					oc_move_array[array_key] = "{   'MOVE_NAME': \"#{move}\", 'MOVE_TYPE': 1005}"
				else
					move = capture_move_name(v.underscore)
					key = k + "_points"
					key = key.to_sym
					oc_move_array[array_key] = "{   'MOVE_NAME': \"#{move[0]}\", 'MOVE_POINTS': #{oc_points_hash[key]}, 'MOVE_TYPE': #{move[1]}}"
				end
			}

			# Print to card
			oc_string = "["
			oc_move_array.each_with_index do |move, index|
				if index < (oc_move_array.size - 1)
					oc_string += "\t#{move}\,\n"
				else
					oc_string += "\t#{move}\]\n\n"
				end
			end
			oc_string
		end

		def make_defensive_card
			m = move_points.select {|key, value| 
				key.to_s.include?("dc")
			}

			dc_array = attributes.select { |k,v| k.include?("dc") }
			reverse_array = dc_array.select { |k,v| v.underscore == "reverse" }

			reverse_array.each { |k,v|
				key = (k + "_points").to_sym
				m[key] = 5
			}

			# Print to card
			defensive_card = "DefensiveCard = ["
			dc = String.new

			m.each { |k, v|
				dc += "#{v}, "
			}
			dc.strip!
			dc[-1] = "]\n"

			defensive_card += dc

			return defensive_card
		end

		def make_specialty_card
			specialty_move = self["specialty"].upcase

			specialty_card = "Specialty = {\t\"#{specialty_move}\": [   {   'MOVE_POINTS': #{move_points[:s1_points]}, 'MOVE_TYPE': #{get_specialty_move_type(self[:s1].underscore)}\},\n"
			specialty_card += "\t\t\t{   'MOVE_POINTS': #{move_points[:s2_points]}, 'MOVE_TYPE': #{get_specialty_move_type(self[:s2].underscore)}\},\n"
			specialty_card += "\t\t\t{   'MOVE_POINTS': #{move_points[:s3_points]}, 'MOVE_TYPE': #{get_specialty_move_type(self[:s3].underscore)}\},\n"
			specialty_card += "\t\t\t{   'MOVE_POINTS': #{move_points[:s4_points]}, 'MOVE_TYPE': #{get_specialty_move_type(self[:s4].underscore)}\},\n"
			specialty_card += "\t\t\t{   'MOVE_POINTS': #{move_points[:s5_points]}, 'MOVE_TYPE': #{get_specialty_move_type(self[:s5].underscore)}\},\n"
			specialty_card += "\t\t\t{   'MOVE_POINTS': #{move_points[:s6_points]}, 'MOVE_TYPE': #{get_specialty_move_type(self[:s6].underscore)}\}\]\}\n"
			specialty_card += "\n"

			specialty_card
		end

		# DRY this with make_oc_card
		def make_ropes_card

			ropes_move_array = Array.new

			ropes_points_hash = move_points.select { |k,v| k.to_s[0..1] == "ro" }
			ropes_moves_hash = attributes.select { |k,v| k[0..1] == "ro" }

			ropes_moves_hash.each { |k,v|
				array_key = (k[2..3].to_i) - 2

				if v.underscore == "n\/a"
					ropes_move_array[array_key] = "{   'MOVE_NAME': 'NA', 'MOVE_POINTS': 0, 'MOVE_TYPE': 1014}"
				elsif v.underscore.include?("(s)")
					move = v.underscore.gsub!("(s)","").upcase.strip
					ropes_move_array[array_key] = "{   'MOVE_NAME': \"#{move}\", 'MOVE_TYPE': 1005}"
				else
					move = capture_move_name(v.underscore)
					key = k + "_points"
					key = key.to_sym
					ropes_move_array[array_key] = "{   'MOVE_NAME': \"#{move[0]}\", 'MOVE_POINTS': #{ropes_points_hash[key]}, 'MOVE_TYPE': #{move[1]}}"
				end
			}

			# Print to card
			ropes_card = ("[")
			ropes_move_array.each_with_index do |move, index|
				if index < (ropes_move_array.size - 1)
					ropes_card += "   #{move}\,\n"
					"\n"
				else
					ropes_card += "   #{move}\]\n"
				end
			end
			ropes_card
		end

		# Just get the move names and not the values
		def capture_move_name(move)

			m = [0, 1008]

			if move.include?('(xx)')
				move.gsub!("(xx)","")
				m[1] = 1009
			elsif move.include?('p/a')
				move.gsub!("p/a","")
				m[1] = 1003
			elsif move.include?('*')
				move.gsub!("*","")
				m[1] = 1004
			elsif move.include?('(dq)')
				move.gsub!("(dq)","")
				m[1] = 1006
			elsif move.include?('(s)')
				move.gsub!("(s)","")
				m[1] = 1005
			elsif move.include?("N/A")
				move.gsub!("N/A","")
				m[1] = 1014
			end
			move.gsub!(/\d+/, "")
			move.strip!
			m[0] = move.upcase

			return m
		end
	end

	def get_specialty_move_type(move)
		if move.include?('(xx)')
				return 1009
			elsif move.include?('p/a')
				return 1003
			elsif move.include?('*')
				return 1004
			elsif move.include?('(dq)')
				return 1006
			else
				return 1005
			end
	end

	def check_sub_tag_value(value)
		if value == 0
			return " "
		else
			return value
		end
	end

	def get_wrestler_file_name
		card_name = "#{self[:name]} #{self[:set]}"
		card_name.gsub(".", "")
	end

	def self.included(receiver)
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
	end

end