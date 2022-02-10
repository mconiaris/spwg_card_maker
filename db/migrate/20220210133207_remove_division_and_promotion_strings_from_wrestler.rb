class RemoveDivisionAndPromotionStringsFromWrestler < ActiveRecord::Migration[7.0]
  def change
    change_table :wrestlers do |t|
      t.remove :division, :promotion
    end
  end
end
