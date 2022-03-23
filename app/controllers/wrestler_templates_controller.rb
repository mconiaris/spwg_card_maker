class WrestlerTemplatesController < ApplicationController

  include WrestlerInitialValues

  # TODO: DRY this up.
  def new
    generate_template_values(params)
  end

end
