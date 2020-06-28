namespace :players do
  desc "Import users from old database"
  task import: :environment do
    path = Rails.root.join("db/current-player.csv")
    data = File.open(path, "r").read.split("\n")
    club = Club.find_by!(name: "No Info")
    data.each do |line|
      items = line.split(",")
      is_male = items[2]
      display_name = items[1]
      name = display_name.downcase
      player = Player.find_by(name: name)
      if (not player)
        Player.create(name: name, display_name: display_name, is_male: is_male, club_id: club.id, birthyear: 0)
      end
    end
  end
end
