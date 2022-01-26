module WrestlersHelper
	def generate_wrestler_stats(wrestler)

		stats = wrestler.analyze

		wrestler.tt = stats[:tt_probability]
		wrestler.card_rating = stats[:total_card_rating]
		wrestler.oc_prob = stats[:oc_probability]
 		wrestler.total_points = stats[:total_card_points_per_round]
 		wrestler.dq_prob = stats[:dq_probability_per_round]
 		wrestler.pa_prob = stats[:pa_probability_per_round]
 		wrestler.sub_prob = stats[:sub_probability_per_round]
 		wrestler.xx_prob = stats[:xx_probability_per_round]
 		wrestler.submission = stats[:submission]
 		wrestler.tag_team_save = stats[:tag_team_save]
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

	def sub_and_tag_display(x, y)
		if x == 0 || x == nil || x == ""
			return y
		elsif y == 0 || y == nil || y == ""
			return x
		else
			return "#{x}-#{y}"
		end
	end

	def print_out_wrestler_errors(wrestler)
		# <div id="error_explanation">
  #   <h2><%= pluralize(@wrestler.errors.count, "error") %> prohibited this article from being saved:</h2>

  #   <ul>
  #     <% @wrestler.errors.each do |error| %>
  #       <li><%= error.full_message %></li>
  #       puts error.full_message
  #     <% end %>
  #   </ul>
  # </div>
  "These are errors."
	end
end
