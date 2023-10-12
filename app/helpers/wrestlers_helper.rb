module WrestlersHelper

	def sub_and_tag_display(x, y)
		if x == 0 || x == nil || x == ""
			return y
		elsif y == 0 || y == nil || y == ""
			return x
		else
			return "#{x}-#{y}"
		end
	end

	def priority_factor_display(s, t)
		if s == "6"
			s = "5+"
		end

		if t == "4"
			t = "3+"
		end

		return "#{s}/#{t}"
	end

	def singles_priority_display(s)
		if s == "6"
			s = "5+"
		end

		return s
	end

	def tag_team_priority_display(t)
		if t == "4"
			t = "3+"
		end

		return t
	end

	def sort_name_display(wn, cn)
		if wn == "Custom Card"
			return cn
		else
			return wn
		end
	end

	def show_wrestler_overview(w)
		card_set = w.set
		card_rating = "%.1f" % w.card_rating
		card_oc_prob = number_to_percentage((w.oc_prob.to_f * 100), precision: 0)
		card_points = "%.1f" % w.total_points
		card_pin_prob = number_to_percentage((w.pa_prob.to_f * 100), precision: 0)
		card_sub_prob = number_to_percentage((w.sub_prob.to_f * 100), precision: 0)

		return "#{card_set} (#{card_rating} / #{card_oc_prob} / #{card_points} / #{card_pin_prob} / #{card_sub_prob})"
	end

end
