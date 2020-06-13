# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  date       :date
#  event      :string           not null
#  handicap   :integer          default(0)
#  komi       :decimal(2, 1)    not null
#  result     :string
#  round      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  black_id   :integer
#  white_id   :integer
#
# Indexes
#
#  index_matches_on_black_id  (black_id)
#  index_matches_on_white_id  (white_id)
#
# Foreign Keys
#
#  black_id  (black_id => players.id)
#  white_id  (white_id => players.id)
#
FactoryBot.define do
  factory :match do
    event { 'Test event'}
    komi { 6.5 }
    result { 'B+5.5' }
    handicap { 0 }
  end
end
