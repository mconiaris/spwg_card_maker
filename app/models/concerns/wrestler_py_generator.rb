module WrestlerPyGenerator
	attr_accessor :card


	module ClassMethods
		
	end


	
	module InstanceMethods

		def print_card

			file = File.new("#{get_wrestler_file_name}.txt", 'w')
			file.write("# -*- coding: utf-8 -*-\n")
			file.write("from data.globalConstants import *\n")
			file.write("# #{self[:name]}\n")
			file.write("name = '#{self[:name]}'\n")
			file.write("\n")
			file.write("# General Card Definitions: \n")
			file.write("#    1000 = OC\n")
			file.write("#    1001 = OC/TT\n")
			file.write("#    1002 = DC\n")
			file.write("GeneralCard = #{make_general_card}\n")
			file.write("\n")
			file.write("# Offensive Card Definitions:\n")
			file.write("#    1003 = Pin attempt move (P/A)\n")
			file.write("#    1004 = Submission Move (*)\n")
			file.write("#    1005 = Specialty Move (S)\n")
			file.write("#    1006 = Disqualification Move (DQ)\n")
			file.write("#    1008 = Regular Offensive Move\n")
			file.write("#    1009 = Grudge Match Move (XX)\n")
			file.write("#    1010 = Ropes Move (ROPES)\n")
			file.write("OffensiveCard = \\\n")
			make_offensive_card(file)
			file.write("# Defensive Card Definitions:\n")
			file.write("#    0 = B - No points on defense\n")
			file.write("#    2 = A - 2 points on defense\n")
			file.write("#    4 = C - 4 points on defense and neutralize offensive move\n")
			file.write("#    5 = Reverse - Reverse offensive move\n")
			make_defensive_card(file)
			file.write("\n")
			file.write("# Specialty Card Definitions:\n")
			file.write("#    1003 = Pin attempt move (P/A)\n")
			file.write("#    1004 = Submission Move (*)\n")
			file.write("#    1005 = Specialty Move (S)\n")
			file.write("#    1006 = Disqualification Move (DQ)\n")
			make_specialty_card(file)
			file.write("# Ropes Card Definitions:\n")
			file.write("#    1003 = Pin attempt move (P/A)\n")
			file.write("#    1004 = Submission Move (*)\n")
			file.write("#    1005 = Specialty Move (S)\n")
			file.write("#    1006 = Disqualification Move (DQ)\n")
			file.write("#    1008 = Regular Offensive Move\n")
			file.write("#    1009 = Grudge Match Move (XX)\n")
			file.write("#    1010 = Ropes Move (ROPES)\n")
			file.write("#    1014 = No Action (NA)\n")
			file.write("Ropes = \\\n")
			make_ropes_card(file)
			file.write("\n")
			file.write("Sub = (#{check_sub_tag_value(self[:subx])}, #{check_sub_tag_value(self[:suby])})\n")
			file.write("TagTeam = (#{check_sub_tag_value(self[:tagx])}, #{check_sub_tag_value(self[:tagy])})\n")
			file.write("Priority = (#{self[:prioritys]}, #{self[:priorityt]})\n")
			file.write("nameSet = '#{self[:set]}'")
			file.close
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

		def make_offensive_card(file)

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
					oc_move_array[array_key] = "{   'MOVE_NAME': '#{move}', 'MOVE_TYPE': 1005}"
				else
					move = capture_move_name(v.underscore)
					key = k + "_points"
					key = key.to_sym
					oc_move_array[array_key] = "{   'MOVE_NAME': '#{move[0]}', 'MOVE_POINTS': '#{oc_points_hash[key]}', 'MOVE_TYPE': #{move[1]}}"
				end
			}

			# Print to card
			file.write("[   ")
			oc_move_array.each_with_index do |move, index|
				if index < (oc_move_array.size - 1)
					file.write("\t#{move}\,")
					file.write("\n")
				else
					file.write("\t#{move}\]\n\n")
				end
			end
		end

		def make_defensive_card(file)
			m = move_points.select {|key, value| 
				key.to_s.include?("dc")
			}

			# Print to card
			file.write("DefensiveCard = [")
			dc = String.new

			m.each { |k, v|
				dc += "#{v}, "
			}
			dc.strip!
			dc[-1] = "]\n"

			file.write(dc)
		end

		def make_specialty_card(file)
			specialty_move = self["specialty"].upcase

			file.write("Specialty = {   '#{specialty_move}': [   {   'MOVE_POINTS': #{move_points[:s1_points]}, 'MOVE_TYPE': #{get_specialty_move_type(self[:s1])}\},\n")
			file.write("                         {   'MOVE_POINTS': #{move_points[:s2_points]}, 'MOVE_TYPE': #{get_specialty_move_type(self[:s2])}\},\n")
			file.write("                         {   'MOVE_POINTS': #{move_points[:s3_points]}, 'MOVE_TYPE': #{get_specialty_move_type(self[:s3])}\},\n")
			file.write("                         {   'MOVE_POINTS': #{move_points[:s4_points]}, 'MOVE_TYPE': #{get_specialty_move_type(self[:s4])}\},\n")
			file.write("                         {   'MOVE_POINTS': #{move_points[:s5_points]}, 'MOVE_TYPE': #{get_specialty_move_type(self[:s5])}\},\n")
			file.write("                         {   'MOVE_POINTS': #{move_points[:s6_points]}, 'MOVE_TYPE': #{get_specialty_move_type(self[:s6])}\}\]\}\n")
			file.write("\n")
		end

		# DRY this with make_oc_card
		def make_ropes_card(file)

			ropes_move_array = Array.new

			ropes_points_hash = move_points.select { |k,v| k.to_s[0..1] == "ro" }
			ropes_moves_hash = attributes.select { |k,v| k[0..1] == "ro" }

			ropes_moves_hash.each { |k,v|
				array_key = (k[2..3].to_i) - 2

				if v.underscore == "n\/a"
					ropes_move_array[array_key] = "{   'MOVE_NAME': 'NA', 'MOVE_POINTS': 0, 'MOVE_TYPE': 1014}"
				elsif v.underscore.include?("(s)")
					move = v.underscore.gsub!("(s)","").upcase.strip
					ropes_move_array[array_key] = "{   'MOVE_NAME': '#{move}', 'MOVE_TYPE': 1005}"
				else
					move = capture_move_name(v.underscore)
					key = k + "_points"
					key = key.to_sym
					ropes_move_array[array_key] = "{   'MOVE_NAME': '#{move[0]}', 'MOVE_POINTS': '#{ropes_points_hash[key]}', 'MOVE_TYPE': #{move[1]}}"
				end
			}

			# Print to card
			file.write("[   ")
			ropes_move_array.each_with_index do |move, index|
				if index < (ropes_move_array.size - 1)
					file.write("\t#{move}\,")
					file.write("\n")
				else
					file.write("\t#{move}\]\n")
				end
			end
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
		card_name = "#{self[:name]}_#{self[:set]}"
		card_name.gsub(" ", "_")
	end

	def self.included(receiver)
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
	end

end