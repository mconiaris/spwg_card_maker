class AddDefaultValueForNameToDivision < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:division, :name, from: nil, to: "None")
  end
end
