# frozen_string_literal: true

# == Schema Information
#
# Table name: players
#
#  id           :integer          not null, primary key
#  birthyear    :integer
#  display_name :string
#  is_male      :integer          default(1), not null
#  name         :string           not null
#  rating       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  club_id      :integer
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
  belongs_to :club, optional: true
  has_many :matches, lambda { |player|
    unscope(:where).where(white: player).or(where(black: player))
  }

  def find_for_club(club_id)
    Player.where(club_id: club_id).all
  end

  def active?
    !matches.empty? && (matches.maximum(:date) >= (Date.today - 365 * 3))
  end

  def screen_name
    return display_name if display_name
    return name.split.map(&:capitalize).join(' ')
  end
end
