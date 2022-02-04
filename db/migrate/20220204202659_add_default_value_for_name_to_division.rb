class AddDefaultValueForNameToDivision < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:name, :state, from: nil, to: "None")
  end
end
