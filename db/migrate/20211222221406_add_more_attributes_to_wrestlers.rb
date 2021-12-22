class AddMoreAttributesToWrestlers < ActiveRecord::Migration[7.0]
  def change
    add_column :wrestlers, :specialty, :string
  end
end
