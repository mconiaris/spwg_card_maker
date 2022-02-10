class AddPromotionKeyToWrestlers < ActiveRecord::Migration[7.0]
  def change
    add_reference :wrestlers, :promotion, foreign_key: true
    change_column_default(:promotion, :name, from: nil, to: "None")
  end
end
