class WrestlerTemplatesController < ApplicationController

  # TODO: DRY this up.
  def new
    case params[:oc]
    when "6"
      @wrestler = Wrestler.new({ gc02: "OC", gc03: "DC", 
        gc04: "DC", gc05: "DC", gc06: "DC", gc07: "DC", 
        gc08: "DC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "OC" })
    when "8"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "OC", 
        gc04: "DC", gc05: "DC", gc06: "DC", gc07: "DC",
        gc08: "DC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "OC" })
    when "11"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "OC", gc05: "DC", gc06: "DC", gc07: "DC",
        gc08: "DC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "OC" })
    when "13"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "DC", gc05: "OC", gc06: "DC", gc07: "DC",
        gc08: "DC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "OC" })
    else
      @wrestler = Wrestler.new
    end
  end

  private

end
