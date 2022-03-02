class WrestlersTagValidator < ActiveModel::Validator

  # TODO: Move variables to private?
  def validate(record)
    gc_hash = get_gc_hash(record)
    tag_hash = gc_hash.select { |k,v| v.include?("TT") }
    tag_enum = get_tag_enumerator(tag_hash)

    unless valid_tag_value?(record, tag_enum)
      record.errors.add :priorityt, "of 3 or 3+ should have OC rolls of 6, 7, or 8. Tag Priorities of 1 should have rolls of 2, 3, 11 or 12. Anything in between should have a tag value of 2."
    end
  end

  private

  def get_gc_hash(record)
    { 2 => record.gc02, 3 => record.gc03, 4 => record.gc04,
      5 => record.gc05, 6 => record.gc06, 7 => record.gc07,
      8 => record.gc08, 9 => record.gc09, 10 => record.gc10,
      11 => record.gc11, 12 => record.gc12 }
  end

  def get_tag_enumerator(tag_hash)
    tag_enum = 0
    tag_hash.each { |k,v|
      if k < 8
        tag_enum += (k-1)
      elsif k == 8
        tag_enum += 5
      elsif k == 9
        tag_enum += 4
      elsif k == 10
        tag_enum += 3
      elsif k == 11
        tag_enum += 2
      elsif k == 12
        tag_enum += 1
      else
        puts "error"
      end
    }
    return tag_enum
  end

  def valid_tag_value?(record, tag_enum)
    tag_pri = record.priorityt

    if tag_pri == "1" && tag_enum > 2
      record.errors.add :priorityt, "is too low based on it's OC/TT roll percentage. Either raise the Tag Priority or lower the chances of double teaming."
    elsif tag_pri == "2" && (tag_enum < 3 && tag_enum > 6)
      record.errors.add :priorityt, "is out of range for it's probability to double team. Place 'OC/TT' in between GC04 and GC10."
    elsif tag_pri == "3" && tag_enum < 5
      record.errors.add :priorityt, "is too high based on the probability of double teaming. Either lower the priority number or place the 'OC/TT' roll in between GC06 and GC08."
    elsif tag_pri == "4" && tag_enum < 5
      record.errors.add :priorityt, "is too high based on the probability of double teaming. Either lower the priority number or place the 'OC/TT' roll in between GC06 and GC08."
    elsif tag_pri == "3+" && tag_enum < 5
      record.errors.add :priorityt, "is too high based on the probability of double teaming. Either lower the priority number or place the 'OC/TT' roll in between GC06 and GC08."
    else
      return true
    end
  end


end
