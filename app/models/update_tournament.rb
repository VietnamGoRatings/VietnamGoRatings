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
class UpdateTournament < UpdateFromFile
  def process_file
    parsed_data = JSON.parse(data)
    date = Date.parse(parsed_data["date"]) if parsed_data["date"] != ""
    type = parsed_data["official_sheet"]
    if type == "1"
      parser_data = TournamentOfficialParser.new.call(RubyXL::Parser.parse_buffer(file.download))
    else
      parser_data = TournamentParser.new.call(RubyXL::Parser.parse_buffer(file.download))
    end

    matches = parser_data[1]
    tournament_name = parser_data[2]
    ActiveRecord::Base.transaction do
      tournament = Tournament.create(name: tournament_name, start_date: date, end_date: date)
      matches.each do |match|
        black_id = Player.find_or_create_by!(name: match[:black_name]).id
        puts match[:white_name]
        white = Player.find_or_create_by!(name: match[:white_name])
        white_id = white.id
        result = match[:result]
        if tournament_name != nil
          Match.create!(black_id: black_id, white_id: white_id,
                       result: result, date: date, event:tournament_name,
                       komi: 6.5, tournament: tournament)
        else
          Match.create!(black_id: black_id, white_id: white_id,
                       result: match[:result], date: match[:date],
                       event: match[:event], round: match[:round],
                       komi: match[:komi], tournament: tournament)
        end
      end
    end
  end
end
