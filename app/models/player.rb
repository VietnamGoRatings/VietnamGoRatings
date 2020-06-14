# frozen_string_literal: true

# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  club_id    :integer          not null
#
# Indexes
#
#  index_players_on_club_id  (club_id)
#
# Foreign Keys
#
#  club_id  (club_id => clubs.id)
#
class Player < ApplicationRecord
  belongs_to :club
  has_many :matches, ->(player) {
    unscope(:where).where(white: player).or(where(black: player))
  }

  def find_for_club(club_id)
    Player.where(club_id: club_id).all
  end
end
