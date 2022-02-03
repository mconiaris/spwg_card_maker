class WrestlerMovesValidator < ActiveModel::EachValidator

  # TODO: boolean for points_valid? and move_value_valid? both must return
  # TODO: Dynamic errors.
  def validate_each(record, attribute, value)
    valid_move_values = options.fetch(:valid_move_values, %w{P/A * (DQ) (XX})
    unless is_move_value_valid?(record, attribute, value, valid_move_values)
      record.errors.add(attribute, (options[:message] || 
        "move must end with #{valid_move_values} or a points value of 0-25"))
    end
  end

  private

  def is_move_value_valid?(record, attribute, value, valid_move_values)
    move = value.split

    if move.last.present? && valid_move_values.include?(move.last) && move.last != "(DQ)"
      points_value?(move[-2]) && valid_points_number(move[-2]) ||
        record.errors.add(attribute, message: "Incorrect entry.")
    else
      true
    end
  end

  def points_value?(value)
    Integer(value) rescue false
  end

  def valid_points_number(value)
    (0..25).include?(value.to_i)
  end

end