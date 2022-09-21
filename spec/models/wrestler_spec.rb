require 'rails_helper'

RSpec.describe Wrestler, type: :model do

  def new_wrestler
    Wrestler.new({"name"=>"83_03BobbyB", "set"=>"SuperSet '83", "tt"=>0.0555555555555556, "card_rating"=>11.7710843827796, "oc_prob"=>0.694444444444444, "total_points"=>6.29795123806076, "dq_prob"=>0.000535836762688614, "pa_prob"=>0.214334705075446, "sub_prob"=>0.0886809842249657, "xx_prob"=>0.0771604938271605, "submission"=>0.0833333333333333, "tag_team_save"=>0.277777777777778, "gc02"=>"DC", "gc03"=>"OC", "gc04"=>"DC", "gc05"=>"OC", "gc06"=>"OC", "gc07"=>"OC", "gc08"=>"OC", "gc09"=>"DC", "gc10"=>"DC", "gc11"=>"OC/TT", "gc12"=>"OC", "dc02"=>"B", "dc03"=>"B", "dc04"=>"A", "dc05"=>"A", "dc06"=>"A", "dc07"=>"A", "dc08"=>"C", "dc09"=>"Reverse", "dc10"=>"B", "dc11"=>"B", "dc12"=>"A", "s1"=>"10", "s2"=>"9*", "s3"=>"10", "s4"=>"9*", "s5"=>"12", "s6"=>"10*", "prioritys"=>"5", "priorityt"=>"1", "oc02"=>"Suplex 11 P/A", "oc03"=>"Spin Under Take Down 8", "oc04"=>"Chicken Wing (S)", "oc05"=>"Cross Ankle Pick Up 6 (xx)", "oc06"=>"Atomic Spine Crusher 9", "oc07"=>"Monkey Flip 8 P/A", "oc08"=>"Vertical Shoulder Block 7", "oc09"=>"Body Slam 8 P/A", "oc10"=>"Reverse Backbridge 9*", "oc11"=>"Hammer Lock 8", "oc12"=>"Ropes", "ro02"=>"Throw Out Of Ring (DQ)", "ro03"=>"N/A", "ro04"=>"Monkey Flip 6", "ro05"=>"Shoulder Block 8", "ro06"=>"Back Drop 7", "ro07"=>"Chicken Wing (S)", "ro08"=>"Arm Drag 7", "ro09"=>"Body Slam 9 P/A", "ro10"=>"Kick To Kneecap 8", "ro11"=>"N/A", "ro12"=>"Chicken Wing (S)", "subx"=>2, "suby"=>3, "tagy"=>5, "specialty"=>"Chicken Wing", "tagx"=>"2", "notes"=>"WWF World Heavyweight champion in December 1982.", "personal_info"=>nil, "full_name"=>"Bob Backlund", "era"=>"Original", "year"=>1983, "position"=>"World Champion"})
  end

  before(:example) do
    @wrestler = new_wrestler
  end


  it "is valid with valid attributes" do
    expect(@wrestler).to be_valid    
  end
  it "is not valid without a name"
  it "is not valid without a set"
  it "is not valid without a tt"
  it "is not valid without a card rating"
end
