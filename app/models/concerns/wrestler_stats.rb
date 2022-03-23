require 'active_support/concern'

module WrestlerStats
  extend ActiveSupport::Concern

  included do
    scope :disabled, -> { where(disabled: true) }
  end


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

    wrestler.save
  end

end