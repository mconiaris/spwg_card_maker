class AddNotesToWrestlers < ActiveRecord::Migration[7.0]
  def change
    change_table :wrestlers do |t|
      t.text :notes
    end
  end
end
