namespace :import do
  desc "Import players from old database"
  task players: :environment do
    female_name = File.open(Rails.root.join("db/female-name.txt")).read.split("\n")
    path = Rails.root.join("db/current-player.csv")
    data = File.open(path, "r").read.split("\n")
    club = Club.find_by!(name: "No Info")
    data.each do |line|
      items = line.split(",")
      display_name = items[1]
      name = display_name.downcase
      is_male = !female_name.include?(name)
      player = Player.find_by(name: name)
      if (not player)
        Player.create(name: name, display_name: display_name, is_male: is_male, club_id: club.id, birthyear: 0)
      end
    end
  end

  desc "Import tournament from old database"
  task tournamentes: :environment do
    path = Rails.root.join("db/current-tournament.csv")
    data = File.open(path, "r").read.split("\n")
    data.each do |line|
      items = line.split(",")
      name = items[1]
      start_date = items[2]
      end_date = items[3]
      Tournament.find_or_create_by!(name: name, start_date: start_date, end_date: end_date)
    end
  end

  desc "Import matches from old database"
  task matches: :environment do
    path = Rails.root.join("db/current-match.csv")
    data = File.open(path, "r").read.split("\n")
    original_date = Date.new(1970,1,1)
    data.each do |line|
      items = line.split(",")
      black_name = items[0].downcase
      black = Player.find_by!(name: black_name)
      white_name = items[1].downcase
      white = Player.find_by!(name: white_name)
      black_won = items[2]
      result = ((black_won == "1") ? "B+":"W+")
      tournament_name = items[3]
      date = original_date + Integer(items[4])
      Match.find_or_create_by!(date: date, event: tournament_name, komi: 6.5, result: result, black: black, white: white)
    end
  end
end
