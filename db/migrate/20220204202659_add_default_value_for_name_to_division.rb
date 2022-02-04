class AddDefaultValueForNameToDivision < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:divisions, :name, from: nil, to: "None")
  end
end
