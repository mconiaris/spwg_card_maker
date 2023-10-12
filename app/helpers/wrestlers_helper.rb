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
		return "#{w.set} (#{w.card_rating} / #{w.oc_prob} / #{w.total_points} / #{w.pa_prob} / #{w.sub_prob})"
	end

end
