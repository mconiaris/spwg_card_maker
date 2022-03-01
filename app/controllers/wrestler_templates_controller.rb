class WrestlerTemplatesController < ApplicationController
  def new
    @wrestler = Wrestler.new({gc02: "OC"})
  end
end
