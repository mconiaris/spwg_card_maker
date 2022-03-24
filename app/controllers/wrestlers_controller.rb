class WrestlersController < ApplicationController
  include SortWrestlers

  def index
    if params[:sort] == nil
      @wrestlers = Wrestler.all.order(card_rating: :desc)
    else
      @wrestlers = sort_wrestler_index
    end
  end

  def show
    @wrestler = Wrestler.find(params[:id])
    @wrestler.generate_wrestler_stats

    respond_to do |format|
      format.html
      format.text { 
        send_data @wrestler.print_card,
        filename: "#{@wrestler.name.gsub("\'","")} #{@wrestler.set}.txt"
      }
      format.py { 
        send_data @wrestler.print_card,
        filename: "#{@wrestler.get_wrestler_file_name}.py"
      }
      format.csv {
        send_data @wrestler.print_card_values,
        filename: "#{@wrestler.name.gsub("\'","")} #{@wrestler.set}.csv"
      }
    end
  end

  def new
    @wrestler = Wrestler.new({
      card_rating: 0, total_points: 0, dq_prob: 0, 
      pa_prob: 0, sub_prob: 0
    })
  end

  def create
    @wrestler = Wrestler.new(wrestler_params)

    if @wrestler.save
      redirect_to @wrestler
    else
      render :new
    end
  end

  def edit
    @wrestler = Wrestler.find(params[:id])
  end

  def update
    @wrestler = Wrestler.find(params[:id])
                                  
    if @wrestler.update(wrestler_params)
      redirect_to @wrestler
    else
      render :edit
    end
  end

  def destroy
    @wrestler = Wrestler.find(params[:id])
    @wrestler.destroy

    redirect_to root_path
  end

  # TODO: Explore how this works. Review Routes and Custom Methods
  # https://stackoverflow.com/questions/48266905/duplicate-an-entry-in-rails-from-show-page
  def dup_wrestler
    @wrestler = Wrestler.find(params[:id]).dup
    @wrestler.name = "New Wrestler"
    @wrestler.set = "Your Set Name Here"
    @wrestler.template = false
    # Promotion and division ids are assigned but the user is not given a link to them.
    @wrestler.promotion_id = 7
    @wrestler.division_id = 4

    render :new
  end

  def print_wrestler
    @wrestler = Wrestler.find(params[:id])

    render 'shared/print_wrestler'
  end

  private

  sort_parameter = ""

  def wrestler_params
    params.require(:wrestler).permit(:name, :set, :gc02, :gc03, :gc04, 
      :gc05, :gc06, :gc07, :gc08, :gc09, :gc10, :gc11, :gc12, :dc02, :dc03, 
      :dc04, :dc05, :dc06, :dc07, :dc08, :dc09, :dc10, :dc11, :dc12, :specialty, 
      :s1, :s2, :s3, :s4, :s5, :s6, :subx, :suby, :tagx,:tagy, :prioritys,  
      :priorityt, :oc02, :oc03, :oc04, :oc05, :oc06, :oc07, :oc08, :oc09, :oc10, 
      :oc11, :oc12, :ro02, :ro03, :ro04, :ro05, :ro06, :ro07, :ro08, :ro09, :ro10,
      :ro11, :ro12, :division_id, :promotion_id)
  end

end
