class AddPersonalInfoToWrestlers < ActiveRecord::Migration[7.0]
  def change
    add_column :wrestlers, :personal_info, :string
  end
end
