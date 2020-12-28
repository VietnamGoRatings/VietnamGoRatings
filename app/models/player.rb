# frozen_string_literal: true

# == Schema Information
#
# Table name: players
#
#  id           :integer          not null, primary key
#  birthyear    :integer          not null
#  display_name :string           not null
#  is_male      :integer          default(1), not null
#  name         :string           not null
#  rating       :integer
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
class Player < ApplicationRecord
  belongs_to :club
  has_many :matches, lambda { |player|
    unscope(:where).where(white: player).or(where(black: player))
  }

  def find_for_club(club_id)
    Player.where(club_id: club_id).all
  end

  def active?
    !matches.empty? && (matches.maximum(:date) >= (Date.today - 365 * 3))
  end
end
