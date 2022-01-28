class WrestlerMovesValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
  	unless is_move_value?(attribute, value)
      record.errors.add attribute, (options[:message] || 
        "move must end with ROPES, a points value, P/A, *, (DQ) or (XX).")
    end

  end


  private

  def is_move_value?(attribute, value)
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