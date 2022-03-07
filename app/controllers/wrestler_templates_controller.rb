class WrestlerTemplatesController < ApplicationController

  # TODO: DRY this up.
  def new
    case params[:oc]
    when "6"
      @wrestler = Wrestler.new(get_initial_wrestler_values({ gc02: "OC/TT", gc12: "OC" }))
    when "8"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "OC", 
        gc04: "DC", gc05: "DC", gc06: "DC", gc07: "DC",
        gc08: "DC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "OC/TT" })
    when "11"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "OC", gc05: "DC", gc06: "DC", gc07: "DC",
        gc08: "DC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "OC/TT" })
    when "14"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "DC", gc05: "OC", gc06: "DC", gc07: "DC",
        gc08: "DC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "OC/TT" })
    when "17"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "DC", gc05: "DC", gc06: "OC", gc07: "DC",
        gc08: "DC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "OC/TT" })
    when "19"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "DC", gc05: "DC", gc06: "DC", gc07: "OC",
        gc08: "DC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "OC/TT" })
    when "22"
      @wrestler = Wrestler.new({ gc02: "OC/TT", gc03: "DC",
        gc04: "DC", gc05: "DC", gc06: "DC", gc07: "OC",
        gc08: "DC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "OC" })
    when "25"
      @wrestler = Wrestler.new({ gc02: "OC/TT", gc03: "DC",
        gc04: "DC", gc05: "DC", gc06: "DC", gc07: "OC",
        gc08: "DC", gc09: "DC", gc10: "DC", gc11: "OC", 
        gc12: "DC" })
    when "28"
      @wrestler = Wrestler.new({ gc02: "OC/TT", gc03: "DC",
        gc04: "DC", gc05: "DC", gc06: "OC", gc07: "DC",
        gc08: "DC", gc09: "OC", gc10: "DC", gc11: "DC", 
        gc12: "DC" })
    when "31"
      @wrestler = Wrestler.new({ gc02: "OC/TT", gc03: "DC",
        gc04: "DC", gc05: "DC", gc06: "OC", gc07: "DC",
        gc08: "OC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "DC" })
    when "33"
      @wrestler = Wrestler.new({ gc02: "OC/TT", gc03: "DC",
        gc04: "DC", gc05: "DC", gc06: "DC", gc07: "OC",
        gc08: "OC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "DC" })
    when "36"
      @wrestler = Wrestler.new({ gc02: "OC/TT", gc03: "DC",
        gc04: "DC", gc05: "DC", gc06: "DC", gc07: "OC",
        gc08: "OC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "OC" })
    when "39"
      @wrestler = Wrestler.new({ gc02: "OC/TT", gc03: "OC",
        gc04: "DC", gc05: "DC", gc06: "DC", gc07: "OC",
        gc08: "OC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "DC" })
    when "42"
      @wrestler = Wrestler.new({ gc02: "OC/TT", gc03: "DC",
        gc04: "OC", gc05: "DC", gc06: "DC", gc07: "OC",
        gc08: "OC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "DC" })
    when "44"
      @wrestler = Wrestler.new({ gc02: "OC/TT", gc03: "DC",
        gc04: "DC", gc05: "OC", gc06: "DC", gc07: "OC",
        gc08: "OC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "DC" })
    when "47"
      @wrestler = Wrestler.new({ gc02: "OC/TT", gc03: "DC",
        gc04: "DC", gc05: "OC", gc06: "DC", gc07: "OC",
        gc08: "OC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "OC" })
    when "50"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "DC", gc05: "DC", gc06: "OC", gc07: "OC",
        gc08: "OC", gc09: "DC", gc10: "DC", gc11: "OC", 
        gc12: "DC" })
    when "53"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "DC", gc05: "DC", gc06: "OC", gc07: "OC",
        gc08: "OC", gc09: "DC", gc10: "OC", gc11: "DC", 
        gc12: "DC" })
    when "56"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "DC", gc05: "DC", gc06: "OC", gc07: "OC",
        gc08: "OC", gc09: "OC", gc10: "DC", gc11: "DC", 
        gc12: "DC" })
    when "58"
      @wrestler = Wrestler.new({ gc02: "OC", gc03: "DC",
        gc04: "DC", gc05: "DC", gc06: "OC", gc07: "OC",
        gc08: "OC", gc09: "OC", gc10: "DC", gc11: "DC", 
        gc12: "DC" })
    when "61"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "OC",
        gc04: "DC", gc05: "DC", gc06: "OC", gc07: "OC",
        gc08: "OC", gc09: "OC", gc10: "DC", gc11: "DC", 
        gc12: "DC" })
    when "64"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "OC", gc05: "DC", gc06: "OC", gc07: "OC",
        gc08: "OC", gc09: "OC", gc10: "DC", gc11: "DC", 
        gc12: "DC" })
    when "67"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "DC", gc05: "OC", gc06: "OC", gc07: "OC",
        gc08: "OC", gc09: "OC", gc10: "DC", gc11: "DC", 
        gc12: "DC" })
    when "69"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "DC", gc05: "OC", gc06: "OC", gc07: "OC",
        gc08: "OC", gc09: "OC", gc10: "DC", gc11: "DC", 
        gc12: "OC" })
    when "72"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "DC", gc05: "OC", gc06: "OC", gc07: "OC",
        gc08: "OC", gc09: "OC", gc10: "DC", gc11: "OC", 
        gc12: "DC" })
    when "75"
      @wrestler = Wrestler.new({ gc02: "DC", gc03: "DC",
        gc04: "DC", gc05: "OC", gc06: "OC", gc07: "OC",
        gc08: "OC", gc09: "OC", gc10: "OC", gc11: "DC", 
        gc12: "DC" })
    else
      @wrestler = Wrestler.new
    end
  end

  private


  def get_initial_wrestler_values(hash)
    wrestler_values = { gc02: "OC/TT", gc03: "DC", 
        gc04: "DC", gc05: "DC", gc06: "DC", gc07: "DC", 
        gc08: "DC", gc09: "DC", gc10: "DC", gc11: "DC", 
        gc12: "OC" }

    return wrestler_values.merge(hash)
  end
end
