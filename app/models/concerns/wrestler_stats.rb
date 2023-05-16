require 'active_support/concern'

module WrestlerStats
  extend ActiveSupport::Concern

  included do
    scope :disabled, -> { where(disabled: true) }
  end


  def set_wrestler_stats
    self.analyze
  end

  def set_default_sort_name
    self.sort_name ||= "Custom Card"
  end

end