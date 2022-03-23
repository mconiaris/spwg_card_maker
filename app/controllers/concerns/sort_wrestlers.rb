require 'active_support/concern'

module SortWrestlers
  extend ActiveSupport::Concern

    # DRY This among controllers. Concern?
  @@sort_order = "ASC"

  def sort_wrestler_index
    if @@sort_order == "ASC"
      @@sort_order = "DESC"
      Wrestler.order(params[:sort])
    else
      @@sort_order = "ASC"
      Wrestler.order("#{params[:sort]} DESC")
    end
  end
end