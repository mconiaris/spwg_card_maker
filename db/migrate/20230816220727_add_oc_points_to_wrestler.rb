class AddOcPointsToWrestler < ActiveRecord::Migration[7.0]
  def change
    add_column :wrestlers, :oc_points, :float
  end
end
