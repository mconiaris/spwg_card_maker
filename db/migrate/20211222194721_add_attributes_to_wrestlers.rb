class AddAttributesToWrestlers < ActiveRecord::Migration[7.0]
  def change
    add_column :wrestlers, :dc02, :string
    add_column :wrestlers, :dc03, :string
    add_column :wrestlers, :dc04, :string
    add_column :wrestlers, :dc05, :string
    add_column :wrestlers, :dc06, :string
    add_column :wrestlers, :dc07, :string
    add_column :wrestlers, :dc08, :string
    add_column :wrestlers, :dc09, :string
    add_column :wrestlers, :dc10, :string
    add_column :wrestlers, :dc11, :string
    add_column :wrestlers, :dc12, :string
    add_column :wrestlers, :s1, :string
    add_column :wrestlers, :s2, :string
    add_column :wrestlers, :s3, :string
    add_column :wrestlers, :s4, :string
    add_column :wrestlers, :s5, :string
    add_column :wrestlers, :s6, :string
    add_column :wrestlers, :prioritys, :string
    add_column :wrestlers, :priorityt, :string
    add_column :wrestlers, :oc02, :string
    add_column :wrestlers, :oc03, :string
    add_column :wrestlers, :oc04, :string
    add_column :wrestlers, :oc05, :string
    add_column :wrestlers, :oc06, :string
    add_column :wrestlers, :oc07, :string
    add_column :wrestlers, :oc08, :string
    add_column :wrestlers, :oc09, :string
    add_column :wrestlers, :oc10, :string
    add_column :wrestlers, :oc11, :string
    add_column :wrestlers, :oc12, :string
    add_column :wrestlers, :ro02, :string
    add_column :wrestlers, :ro03, :string
    add_column :wrestlers, :ro04, :string
    add_column :wrestlers, :ro05, :string
    add_column :wrestlers, :ro06, :string
    add_column :wrestlers, :ro07, :string
    add_column :wrestlers, :ro08, :string
    add_column :wrestlers, :ro09, :string
    add_column :wrestlers, :ro10, :string
    add_column :wrestlers, :ro11, :string
    add_column :wrestlers, :ro12, :string
    add_column :wrestlers, :subx, :integer
    add_column :wrestlers, :suby, :integer
    add_column :wrestlers, :tzgx, :integer
    add_column :wrestlers, :tagy, :integer
  end
end
