class ChangeDefaultNameInPromotions < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:promotions, :name, from: nil, to: "None")
  end
end
