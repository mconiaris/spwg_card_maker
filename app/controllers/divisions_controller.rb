class DivisionsController < ApplicationController

	def index
    @divisions = Division.all
  end

  def show
    @division = Division.find(params[:id])
    @wrestlers = division_filter(@division)
  end

  def new
    @division = Division.new
  end

  def create
    @division = Division.new(division_params)

    if @division.save
      redirect_to @division
    else
      render :new
    end
  end

  def edit
    @division = Division.find(params[:id])
  end

  def update
    @division = Division.find(params[:id])
                                  
    if @division.update(division_params)
      redirect_to @division
    else
      render :edit
    end
  end

  def destroy
    @division = Division.find(params[:id])
    @division.destroy

    redirect_to root_path
  end

  private

  def division_params
    params.require(:division).permit(:name)
  end

  def division_filter(division)
    @wrestlers = Wrestler.all.order(card_rating: :desc)
    @wrestlers.select { |w| w.division == division }
  end
end
