FactoryGirl.define do
  factory :reservation do
    coach ""
    user nil
    time_block nil
    club_table 1
    party_size 1
    type_play? false
    type_lesson? false
  end
end
