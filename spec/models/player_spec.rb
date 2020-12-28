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
require 'rails_helper'
RSpec.describe Player, type: :model do
  describe "matches" do
    let (:player_one) {create(:player, :with_club)}
    let (:player_two) {create(:player, :with_club)}
    before do
      create(:match, white_id: player_one.id, black_id: player_two.id)
      create(:match, white_id: player_two.id, black_id: player_one.id)
    end

    it "returns all matches of a player, both as black and as white" do
      expect(player_one.matches.length).to eq 2
    end
  end
end
