class AddCardMovePointsToWrestler < ActiveRecord::Migration[7.0]
  def change
    add_column :wrestlers, :card_move_points, :float
  end
end
