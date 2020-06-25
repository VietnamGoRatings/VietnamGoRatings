require 'rails_helper'
RSpec.describe 'PlayersParser' do
  context "Test" do
    let(:data) {file_fixture("players.xlsx")}
    it do
      expect(data).to equal(1)
    end
  end
end
