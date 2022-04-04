require 'active_support/concern'

module WrestlerStats
  extend ActiveSupport::Concern

  included do
    scope :disabled, -> { where(disabled: true) }
  end


  def set_wrestler_stats
    self.analyze
  end

end