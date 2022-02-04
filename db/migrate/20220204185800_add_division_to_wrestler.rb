class AddDivisionToWrestler < ActiveRecord::Migration[7.0]
  def change
    add_reference :wrestlers, :division, null: false, foreign_key: true
  end
end
