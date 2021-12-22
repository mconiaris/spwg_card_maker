class CreateWrestlers < ActiveRecord::Migration[7.0]
  def change
    create_table :wrestlers do |t|
      t.string :name
      t.string :set
      t.float :tt
      t.float :card_rating
      t.float :oc_prob
      t.float :total_points
      t.float :dq_prob
      t.float :pa_prob
      t.float :sub_prob
      t.float :xx_prob
      t.float :submission
      t.float :tag_team_save
      t.string :division
      t.string :gc02
      t.string :gc03
      t.string :gc04
      t.string :gc05
      t.string :gc06
      t.string :string
      t.string :gc07
      t.string :gc08
      t.string :gc09
      t.string :gc10
      t.string :gc11
      t.string :gc12

      t.timestamps
    end
  end
end
