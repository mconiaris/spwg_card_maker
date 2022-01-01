module WrestlersHelper
	def generate_wrestler_stats(wrestler)
		stats = wrestler.analyze

		wrestler.tt = stats[:tt_probability]
		wrestler.card_rating = stats[:total_card_rating]
		wrestler.oc_prob = stats[:oc_probability]
 		wrestler.total_points = stats[:total_card_points]
 		wrestler.dq_prob = stats[:dq_probability_per_round]
 		wrestler.pa_prob = stats[:pa_probability_per_round]
 		wrestler.sub_prob = stats[:sub_probability_per_round]
 		wrestler.xx_prob = stats[:xx_probability_per_round]
 		# wrestler.submission = stats[]
 		# wrestler.tag_team_save = stats[]
 		wrestler.save
	end

	def initial_stats(wrestler)
		wrestler.tt = 0
		wrestler.card_rating = 0
		wrestler.oc_prob = 0
 		wrestler.total_points = 0
 		wrestler.dq_prob = 0
 		wrestler.pa_prob = 0
 		wrestler.sub_prob = 0
 		wrestler.xx_prob = 0
 		wrestler.submission = 0
 		wrestler.tag_team_save = 0
	end
end
