class TournamentOfficialParser
  def call(workbook)
    sheet = workbook[0]
    i = 1
    matches = []
    while (sheet[i] != nil && sheet[i][0] != nil)
      black_name = sheet[i][0].value
      white_name = sheet[i][1].value
      result = sheet[i][2].value
      komi = sheet[i][3].value
      handicap = sheet[i][4].value
      date = Date.strptime(sheet[i][5].value, "%d/%m/%Y")
      event = sheet[i][6].value
      round = sheet[i][7].value
      matches.push({black_name: black_name.downcase,
                    white_name: white_name.downcase,
                    result: result,
                    komi: komi,
                    handicap: handicap,
                    date: date,
                    event: event,
                    round: round})
      i += 1
    end
    [nil, matches, nil]
  end
end
