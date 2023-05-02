class AddSortNameAndNumberToWrestlers < ActiveRecord::Migration[7.0]
  def change
    remove_column :wrestlers, :full_name, :string

    add_column :wrestlers, :sort_name, :string
    add_column :wrestlers, :card_number, :string
  end
end
