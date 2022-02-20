module WrestlerPrintValues
	attr_accessor :card

	require 'csv'

	module ClassMethods
		
	end

	
	module InstanceMethods

		def print_card_values

			CSV.generate do |csv|
 			
	 			csv << [ "Name", "Set", "PRI-S", "PRI-TT", "TT%", "Card Rating", "OC Prob", "Total Points Per Round", "DQ Prob", "P/A Prob", "Sub Prob", "XX Prob",	"Sumission Loss",	"Tag Team Save"	]
				csv << [ "#{self.name}", "#{self.set}", "#{self.prioritys}", "#{self.priorityt}", "#{self.tt}", "#{self.card_rating}", "#{self.oc_prob}", "#{self.total_points}", "#{self.dq_prob}", "#{self.pa_prob}", "#{self.sub_prob}", "#{self.xx_prob}", "#{self.submission}", "#{self.tag_team_save}" ]
				csv << [ "" ]
				
				csv << ["Name:", "#{self.name}"]
				csv << [ "gc02:", "#{self.gc02}" ]
				csv << [ "gc03:", "#{self.gc03}"]
				csv << [ "gc04:", "#{self.gc04}"]
				csv << [ "gc05:", "#{self.gc05}"]
				csv << [ "gc06:", "#{self.gc06}"]
				csv << [ "gc07:", "#{self.gc07}"]
				csv << [ "gc08:", "#{self.gc08}"]
				csv << [ "gc09:", "#{self.gc09}"]
				csv << [ "gc10:", "#{self.gc10}"]
				csv << [ "gc11:", "#{self.gc11}"]
				csv << [ "gc12:", "#{self.gc12}"]
				csv << [ "" ]
				
				csv << [ "dc02", "#{self.dc02}" ]
 				csv << [ "dc03", "#{self.dc03}" ]
 				csv << [ "dc04", "#{self.dc04}" ]
 				csv << [ "dc05", "#{self.dc05}" ]
 				csv << [ "dc06", "#{self.dc06}" ]
 				csv << [ "dc07", "#{self.dc07}" ]
 				csv << [ "dc08", "#{self.dc08}" ]
 				csv << [ "dc09", "#{self.dc09}" ]
 				csv << [ "dc10", "#{self.dc10}" ]
 				csv << [ "dc11", "#{self.dc11}" ]
 				csv << [ "dc12", "#{self.dc12}" ]
 				csv << [ "" ]

 				csv << [ "Specialty", "#{specialty}" ]

 				csv << [ "s1:", "#{self.s1}" ]
 				csv << [ "s2:", "#{self.s2}" ]
 				csv << [ "s3:", "#{self.s3}" ]
 				csv << [ "s4:", "#{self.s4}" ]
 				csv << [ "s5:", "#{self.s5}" ]
 				csv << [ "s6:", "#{self.s6}" ]

 				csv << [ "Sub:", "#{self.subx}-#{self.suby}" ]
 				csv << [ "Tag:", "#{self.tagx}-#{self.tagy}" ]
 				csv << [ "Priority:", "#{self.prioritys}/#{self.priorityt}" ]
 				csv << [ "" ]
 				
 				csv << [ "oc02", "#{self.oc02}"]
 				csv << [ "oc03", "#{self.oc03}"]
 				csv << [ "oc04", "#{self.oc04}"]
 				csv << [ "oc05", "#{self.oc05}"]
 				csv << [ "oc06", "#{self.oc06}"]
 				csv << [ "oc07", "#{self.oc07}"]
 				csv << [ "oc08", "#{self.oc08}"]
 				csv << [ "oc09", "#{self.oc09}"]
 				csv << [ "oc10", "#{self.oc10}"]
 				csv << [ "oc11", "#{self.oc11}"]
 				csv << [ "oc12", "#{self.oc12}"]
 				csv << [ "" ]

 				csv << [ "ro02", "#{self.ro02}"]
 				csv << [ "ro03", "#{self.ro03}"]
 				csv << [ "ro04", "#{self.ro04}"]
 				csv << [ "ro05", "#{self.ro05}"]
 				csv << [ "ro06", "#{self.ro06}"]
 				csv << [ "ro07", "#{self.ro07}"]
 				csv << [ "ro08", "#{self.ro08}"]
 				csv << [ "ro09", "#{self.ro09}"]
 				csv << [ "ro10", "#{self.ro10}"]
 				csv << [ "ro11", "#{self.ro11}"]
 				csv << [ "ro12", "#{self.ro12}"]

			end

		end

	end
		private

		def self.included(receiver)
			receiver.extend         ClassMethods
			receiver.send :include, InstanceMethods
		end
		

end