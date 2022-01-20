class WrestlerValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
  	if value == "(DQ)"
  		puts "DQ value entered correctly."
  	else
  		record.errors.add(attribute, "bad input")
  	end
  end

end