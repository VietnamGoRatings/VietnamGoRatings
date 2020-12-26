class UpdateTournament < UpdateFromFile
  def process_file
    parser_data = TournamentParser.new.call(RubyXL::Parser.parse_buffer(file.download))
    date = Date.parse(JSON.parse(data)["date"])
    matches = parser_data[1]
    tournament_name = parser_data[2]
    ActiveRecord::Base.transaction do
      matches.each do |match|
        black_id = Player.find_or_create_by(name: match[:black_name]).id
        white = Player.find_or_create_by(name: match[:white_name])
        white_id = white.id
        result = match[:result]
        Match.create(black_id: black_id, white_id: white_id,
                     result: result, date: date, event:tournament_name,
                     komi: 6.5)
      end
    end
  end
end
