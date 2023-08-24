class RemoveCardMovePointsFromWrestler < ActiveRecord::Migration[7.0]
  def change
    remove_column :wrestlers, :card_move_points
  end
end
