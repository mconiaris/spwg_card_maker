class AddContextToWrestlers < ActiveRecord::Migration[7.0]
  def change
    add_column :wrestlers, :full_name, :string
    add_column :wrestlers, :era, :string
    add_column :wrestlers, :year, :integer
    add_column :wrestlers, :position, :string
  end
end
