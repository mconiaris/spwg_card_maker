class FixTagXErrorinWestlers < ActiveRecord::Migration[7.0]
  def change
    remove_column :wrestlers, :tzgx, :string
    add_column :wrestlers, :tagx, :string
  end
end
