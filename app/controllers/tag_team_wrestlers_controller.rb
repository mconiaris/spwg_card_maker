class TagTeamWrestlersController < ApplicationController

  @@sort_order = "ASC"

  # TODO: Explore how this works and make it cleaner.
  def index
    if params[:sort] == nil
      @wrestlers = Wrestler.where("tt > ? or tag_team_save > ?", 0.13, 0.41).order(tag_team_save: :desc)
    else
      @wrestlers = Wrestler.where("tt > ? or tag_team_save > ?", 0.13, 0.41)
      @wrestlers = sort_wrestler_index
    end
  end

  private

  def sort_wrestler_index
    if @@sort_order == "ASC"
      @@sort_order = "DESC"
      @wrestlers = Wrestler.where("tt > ? or tag_team_save > ?", 0.13, 0.41).order(params[:sort])
    else
      @@sort_order = "ASC"
      @wrestlers = Wrestler.where("tt > ? or tag_team_save > ?", 0.13, 0.41).order("#{params[:sort]} DESC")
    end
  end
end
