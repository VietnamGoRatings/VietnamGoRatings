# frozen_string_literal: true

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
class Match < ApplicationRecord
  belongs_to :white, class_name: 'Player', foreign_key: 'white_id'
  belongs_to :black, class_name: 'Player', foreign_key: 'black_id'
end
