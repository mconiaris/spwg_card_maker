class AddDivisionToWrestler < ActiveRecord::Migration[7.0]
  def change
    add_reference :wrestlers, :division, foreign_key: true
  end
end
