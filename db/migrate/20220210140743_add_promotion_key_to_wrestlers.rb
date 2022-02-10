class AddPromotionKeyToWrestlers < ActiveRecord::Migration[7.0]
  def change
    add_reference :wrestlers, :promotion, foreign_key: true
  end
end
