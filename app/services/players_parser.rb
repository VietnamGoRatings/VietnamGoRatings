# frozen_string_literal: true

class PlayersParser
  def call(data)
    workbook = RubyXL::Parser.parse_buffer data
    players = (workbook[0].map { |x| { name: x[0].value, birthyear: x[1] ? x[1].value : -1 } })\
              .filter { |x| !x[:name].nil? }
    players.shift
    players
  end
end
