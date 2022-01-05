module WrestlerPyGenerator
	attr_accessor :card


	module ClassMethods
		
	end


	
	module InstanceMethods

		def print_card

			file = File.new('wrestler.txt', 'w')
			file.write("# -*- coding: utf-8 -*-\n")
			file.write("from data.globalConstants import *\n")
			file.write("# #{self[:name]}l\n")
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
			make_offensive_card
			# file.write("[   {   'MOVE_NAME': '#{self[:oc02]}', 'MOVE_POINTS': #{move_points[:oc02_points]}, 'MOVE_TYPE': #{move_type("oc02")}},\n")
			# file.write("    {   'MOVE_NAME': '#{self[:oc03]}', 'MOVE_POINTS': #{move_points[, 'MOVE_TYPE': 1008},\n")
			# file.write("    {   'MOVE_NAME': '#{self[:oc04]}', 'MOVE_TYPE': 1005},\n")
			# file.write("    {   'MOVE_NAME': '#{self[:oc05]}', 'MOVE_POINTS': #{move_points[, 'MOVE_TYPE': 1008},\n")
			# file.write("    {   'MOVE_NAME': '#{self[:oc06]}', 'MOVE_POINTS': #{move_points[, 'MOVE_TYPE': 1008},\n")
			# file.write("    {   'MOVE_NAME': '#{self[:oc07]}', 'MOVE_POINTS': #{move_points[, 'MOVE_TYPE': 1008},\n")
			# file.write("    {   'MOVE_NAME': '#{self[:oc08]}', 'MOVE_POINTS': #{move_points[, 'MOVE_TYPE': 1009},\n")
			# file.write("    {   'MOVE_NAME': '#{self[:oc09]}', 'MOVE_POINTS': #{move_points[, 'MOVE_TYPE': 1008},\n")
			# file.write("    {   'MOVE_NAME': '#{self[:oc10]}', 'MOVE_POINTS': #{move_points[, 'MOVE_TYPE': 1003},\n")
			# file.write("    {   'MOVE_NAME': '#{self[:oc11]}', 'MOVE_POINTS': #{move_points[, 'MOVE_TYPE': 1008},\n")
			# file.write("    {   'MOVE_NAME': '#{self[:oc12]}', 'MOVE_TYPE': 1010}]\n")
			# file.write("    \n")
			file.write("# Defensive Card Definitions:\n")
			file.write("#    0 = B - No points on defense\n")
			file.write("#    2 = A - 2 points on defense\n")
			file.write("#    4 = C - 4 points on defense and neutralize offensive move\n")
			file.write("#    5 = Reverse - Reverse offensive move\n")
			file.write("DefensiveCard = [0, 2, 0, 4, 2, 2, 0, 5, 2, 0, 2]\n")
			file.write("\n")
			file.write("# Specialty Card Definitions:\n")
			file.write("#    1003 = Pin attempt move (P/A)\n")
			file.write("#    1004 = Submission Move (*)\n")
			file.write("#    1005 = Specialty Move (S)\n")
			file.write("#    1006 = Disqualification Move (DQ)\n")
			file.write("Specialty = {   'TOMAHAWK DROP': [   {   'MOVE_POINTS': 9, 'MOVE_TYPE': 1003},\n")
			file.write("                         {   'MOVE_POINTS': 10, 'MOVE_TYPE': 1005},\n")
			file.write("                         {   'MOVE_POINTS': 11, 'MOVE_TYPE': 1005},\n")
			file.write("                         {   'MOVE_POINTS': 11, 'MOVE_TYPE': 1005},\n")
			file.write("                         {   'MOVE_POINTS': 10, 'MOVE_TYPE': 1003},\n")
			file.write("                         {   'MOVE_POINTS': 9, 'MOVE_TYPE': 1003}]}\n")
			file.write("                         \n")
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
			file.write("[   {   'MOVE_NAME': 'CHOP OVER TOP ROPE', 'MOVE_TYPE': 1006},\n")
			file.write("    {   'MOVE_NAME': 'FRONT CRADLE', 'MOVE_POINTS': 8, 'MOVE_TYPE': 1003},\n")
			file.write("    {   'MOVE_NAME': 'NA', 'MOVE_POINTS': 0, 'MOVE_TYPE': 1014},\n")
			file.write("    {   'MOVE_NAME': 'FIST TO MIDSECTION', 'MOVE_POINTS': 7, 'MOVE_TYPE': 1008},\n")
			file.write("    {   'MOVE_NAME': 'TOMAHAWK CHOP', 'MOVE_POINTS': 8, 'MOVE_TYPE': 1008},\n")
			file.write("    {   'MOVE_NAME': 'SHOULDER SMASH', 'MOVE_POINTS': 7, 'MOVE_TYPE': 1008},\n")
			file.write("    {   'MOVE_NAME': 'NA', 'MOVE_POINTS': 0, 'MOVE_TYPE': 1014},\n")
			file.write("    {   'MOVE_NAME': 'NA', 'MOVE_POINTS': 0, 'MOVE_TYPE': 1014},\n")
			file.write("    {   'MOVE_NAME': 'RAM INTO RINGPOST', 'MOVE_POINTS': 8, 'MOVE_TYPE': 1008},\n")
			file.write("    {   'MOVE_NAME': 'DBLE TOMAHAWK CHOP', 'MOVE_POINTS': 7, 'MOVE_TYPE': 1008},\n")
			file.write("    {   'MOVE_NAME': 'NA', 'MOVE_POINTS': 0, 'MOVE_TYPE': 1014}]\n")
			file.write("    \n")
			file.write("Sub = (2, 4)\n")
			file.write("TagTeam = (7, 12)\n")
			file.write("Priority = (4, 2)\n")
			file.write("nameSet = 'Rufuscard'")
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
					oc_move_array[array_key] = "{   'MOVE_NAME': '#{move}', 'MOVE_TYPE': 1005}"
				else
					move = capture_move_name(v.underscore)
					key = k + "_points"
					key = key.to_sym
					oc_move_array[array_key] = "{   'MOVE_NAME': '#{move[0]}', 'MOVE_POINTS': '#{oc_points_hash[key]}', 'MOVE_TYPE': #{move[1]}}"
				end
			}
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
			end
			move.gsub!(/\d+/, "")
			move.strip!
			m[0] = move.upcase

			return m
		end
	end

	def self.included(receiver)
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
	end

end