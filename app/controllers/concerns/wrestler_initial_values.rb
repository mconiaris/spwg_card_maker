require 'active_support/concern'

module WrestlerInitialValues
  extend ActiveSupport::Concern

  def generate_template_values(params)
    case params[:oc]
    when "6"
      # 2/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc12: "OC" }))
    when "8"
      # 3/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc11: "OC" }))
    when "11"
      # 4/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc10: "OC" }))
    when "14"
      # 5/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc09: "OC" }))
    when "17"
      # 6/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc08: "OC" }))
    when "19"
      # 7/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc07: "OC" }))
    when "22"
      # 8/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc07: "OC", gc12: "OC" }))
    when "25"
      # 9/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc07: "OC", gc11: "OC" }))
    when "28"
      # 10/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc07: "OC", gc10: "OC" }))
    when "31"
      # 11/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc07: "OC", gc09: "OC" }))
    when "33"
      # 12/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc07: "OC", gc08: "OC" }))
    when "36"
      # 13/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc03: "OC", gc07: "OC", gc10: "OC", gc12: "OC" }))
    when "39"
      # 14/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc10: "OC", 
          gc12: "OC" }))
    when "42"
      # 15/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc06: "OC" }))
    when "44"
      # 16/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc06: "OC", 
          gc12: "OC" }))
    when "47"
      # 17/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc06: "OC", 
          gc11: "OC" }))
    when "50"
      # 18/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc06: "OC", 
          gc10: "OC" }))
    when "53"
      # 19/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc06: "OC", 
          gc09: "OC" }))
    when "56"
      # 20/36
      @wrestler = Wrestler.new(
        get_initial_jobber_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc06: "OC", 
          gc08: "OC" }))
    when "58"
      # 21/36
      @wrestler = Wrestler.new(
        get_initial_wrestler_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc06: "OC", 
          gc07: "OC" }))
    when "61"
      # 22/36
      @wrestler = Wrestler.new(
        get_initial_wrestler_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc06: "OC", 
          gc07: "OC", gc12: "OC" }))
    when "64"
      # 23/36
      @wrestler = Wrestler.new(
        get_initial_wrestler_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc06: "OC", 
          gc07: "OC", gc11: "OC" }))
    when "67"
      # 24/36
      @wrestler = Wrestler.new(
        get_initial_wrestler_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc06: "OC", 
          gc07: "OC", gc10: "OC" }))
    when "69"
      # 25/36
      @wrestler = Wrestler.new(
        get_initial_wrestler_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc06: "OC", 
          gc07: "OC", gc09: "OC" }))
    when "72"
      # 26/36
      @wrestler = Wrestler.new(
        get_initial_wrestler_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc06: "OC", 
          gc07: "OC", gc08: "OC" }))
    when "75"
      # 27/36
      @wrestler = Wrestler.new(
        get_initial_wrestler_values({ gc02: "OC/TT", 
          gc03: "OC", gc04: "OC", gc05: "OC", gc06: "OC", 
          gc07: "OC", gc08: "OC", gc12: "OC" }))
    else
      @wrestler = Wrestler.new
    end
  end

  private


  def get_initial_wrestler_values(hash)
    wrestler_values = get_base_values

    return wrestler_values.merge(hash, get_midcard_dc_values)
  end

  def get_initial_jobber_values(hash)
    wrestler_values = get_base_values

    return wrestler_values.merge(hash, get_jobber_dc_values)
  end


  # TODO: Add separate method to determine OC Prob
  def get_base_values
    gc_values = { gc02: "DC", gc03: "DC", gc04: "DC", 
      gc05: "DC", gc06: "DC", gc07: "DC", gc08: "DC", 
      gc09: "DC", gc10: "DC", gc11: "DC", gc12: "DC", 
      card_rating: 0, total_points: 0, dq_prob: 0, 
      pa_prob: 0, sub_prob: 0
    }
  end

  def get_jobber_dc_values
    dc_values = { dc02: "Reverse", dc03: "A", dc04: "A", 
      dc05: "B", dc06: "B", dc07: "B", dc08: "B", 
      dc09: "A", dc10: "A", dc11: "A", dc12: "C",
      subx: 2, suby: 12, tagx: 2, tagy: 0, prioritys: 1,
      priorityt: 1
    }
  end

  def get_midcard_dc_values
    dc_values = { dc02: "B", dc03: "A", dc04: "Reverse", 
      dc05: "B", dc06: "A", dc07: "A", dc08: "B", 
      dc09: "C", dc10: "A", dc11: "B", dc12: "A" 
    }
  end

end