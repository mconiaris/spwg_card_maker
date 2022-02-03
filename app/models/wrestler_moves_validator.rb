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

    # Checks for valid point range for moves ending in P/A, *, etc.
    if move.present? && valid_move_values.include?(move.last) && move.last != "(DQ)" && move.last.upcase != "ROPES"
      points_value?(move[-2]) && valid_points_number(move[-2]) ||
        record.errors.add(attribute, message: "Move points cannot be higher than 25.")
    # Checks to see if move values ending in points only are within range.
    elsif move.present? && points_value?(move.last)
      (0..25).include?(value.to_i) || record.errors.add(attribute, message: "Move points cannot be higher than 25.")
    # Moves ending in * are checked against valid_move_values seperately
    # because of the way split works.
    elsif move.last.include?("*")
      valid_move_values.include?("*") || record.errors.add(attribute, message: "This cannot be a submission move.")
    elsif move.last.upcase == "ROPES"
      valid_move_values.include?(move.last) || record.errors.add(attribute, message: "Ropes cannot be called in this card.")
    end
  end

  def points_value?(value)
    Integer(value) rescue false
  end

  def valid_points_number(value)
    (0..25).include?(value.to_i)
  end

end