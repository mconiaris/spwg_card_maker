class AddPromotionToWrestlers < ActiveRecord::Migration[7.0]
  def change
    add_column :wrestlers, :promotion, :string
  end
end
