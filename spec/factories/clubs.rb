# == Schema Information
#
# Table name: clubs
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :club do
    name { Faker::Company.name }
  end
end
