# == Schema Information
#
# Table name: update_from_files
#
#  id         :integer          not null, primary key
#  data       :string           not null
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UpdateClubPlayers < UpdateFromFile
  def process_file
    players = PlayersParser.new.call file.download
    club_id = JSON.parse(data)["club_id"]
    players.each do |item|
      normalize_name = item[:name].mb_chars.unicode_normalize(:nfkd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
      birthyear = item[:birthyear]
      player = Player.find_by(name: normalize_name, birthyear: birthyear)
      if (!player)
        Player.create(name: normalize_name, birthyear: birthyear, club_id: club_id, display_name: item[:name])
      end
    end
  end
end
