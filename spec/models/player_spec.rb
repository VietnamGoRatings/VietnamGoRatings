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
