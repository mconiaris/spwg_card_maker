class AddTemplateBooleanToWrestlers < ActiveRecord::Migration[7.0]
  def change
    add_column :wrestlers, :template, :boolean
  end
end
