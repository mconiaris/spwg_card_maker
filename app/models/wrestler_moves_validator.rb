class WrestlerMovesValidator < ActiveModel::EachValidator

  # TODO: boolean for points_valid? and move_value_valid? both must return
  # TODO: Dynamic errors.
  def validate_each(record, attribute, value)
    valid_move_values = options.fetch(:valid_move_values, %w{P/A * (DQ) (XX})
    unless is_move_value_valid?(attribute, value)
      record.errors.add(attribute, (options[:message] || 
        "move must end with #{valid_move_values} or a points value of 0-25"))
    end
  end

  private

  def is_move_value_valid?(attribute, value)
    move = value.split

    if move.size < 2
      points_value?(move[0])
    else
      points_value?(move[-2]) && special_value?(move[-1])
    end
  end

  def special_value?(value)
    if value == "P/A" || value == "*" || value == "(XX)" || value == "(DQ)"
      true
    else
      false
    end    
  end

  def points_value?(value)
    Integer(value) rescue false
  end

end