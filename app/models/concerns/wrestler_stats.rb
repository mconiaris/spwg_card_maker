require 'active_support/concern'

module WrestlerStats
  extend ActiveSupport::Concern

  included do
    scope :disabled, -> { where(disabled: true) }
  end


  def set_wrestler_stats

    self.analyze

    # self.tt = stats[:tt_probability]
    # self.card_rating = stats[:total_card_rating]
    self.oc_prob = oc_probability
    # self.total_points = stats[:total_card_points_per_round]
    # self.dq_prob = stats[:dq_probability_per_round]
    # self.pa_prob = stats[:pa_probability_per_round]
    # self.sub_prob = stats[:sub_probability_per_round]
    # self.xx_prob = stats[:xx_probability_per_round]
    # self.submission = stats[:submission]
    # self.tag_team_save = stats[:tag_team_save]

  end

end