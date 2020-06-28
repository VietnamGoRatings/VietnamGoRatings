# == Schema Information
#
# Table name: players
#
#  id           :integer          not null, primary key
#  birthyear    :integer          not null
#  display_name :string           not null
#  is_male      :integer          default(1), not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  club_id      :integer          not null
#
# Indexes
#
#  index_players_on_club_id             (club_id)
#  index_players_on_name_and_birthyear  (name,birthyear) UNIQUE
#
# Foreign Keys
#
#  club_id  (club_id => clubs.id)
#
FactoryBot.define do
  factory :player do
    trait :with_club do
      association :club, factory: :club
    end
    name { Faker::Name.name }
    display_name {:name}
    birthyear {Faker::Number.between(from: 1940, to: 2050)}
  end
end
