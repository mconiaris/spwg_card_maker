class WrestlersController < ApplicationController
  def index
    @wrestlers = Wrestler.all
  end

  def show
    @wrestler = Wrestler.find(params[:id])

    respond_to do |format|
      format.html
      format.text { 
        send_data @wrestler.print_card,
        filename: "#{@wrestler.name.gsub("\'","")} #{@wrestler.set}.txt"
      }
      format.py { 
        send_data @wrestler.print_card,
        filename: "#{@wrestler.name.gsub("\'","")} #{@wrestler.set}.py"
      }
    end
  end

  def new
    @wrestler = Wrestler.new
  end

  # TODO: Add dummy values
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

  private

  def wrestler_params
    params.require(:wrestler).permit(:name, :set, :gc02, :gc03, :gc04, 
      :gc05, :gc06, :gc07, :gc08, :gc09, :gc10, :gc11, :gc12, :dc02, :dc03, 
      :dc04, :dc05, :dc06, :dc07, :dc08, :dc09, :dc10, :dc11, :dc12, :specialty, 
      :s1, :s2, :s3, :s4, :s5, :s6, :subx, :suby, :tagx,:tagy, :prioritys,  
      :priorityt, :oc02, :oc03, :oc04, :oc05, :oc06, :oc07, :oc08, :oc09, :oc10, 
      :oc11, :oc12, :ro02, :ro03, :ro04, :ro05, :ro06, :ro07, :ro08, :ro09, :ro10,
      :ro11, :ro12, :division, :promotion)
  end


end
