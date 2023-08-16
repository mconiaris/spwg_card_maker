class RemoveOcPointsToWrestler < ActiveRecord::Migration[7.0]
  def change
    remove_column :wrestlers, :oc_points
  end
end
