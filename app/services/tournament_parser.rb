class TournamentParser
  def call(workbook)
    sheet = workbook[0]

    players = []
    tournament_name = sheet[1][0].value
    i = 2
    while (sheet[i][0].value != 1)
      i+=1
    end

    j=i
    player_pos_mapping = {}
    pos_player_mapping = {}
    player_pos = 1
    while(sheet[j] != nil && sheet[j][1] != nil)
      puts j
      name = normalize_name(sheet[j][1].value.strip)
      players.push(name)
      player_pos_mapping[name] = player_pos
      pos_player_mapping[player_pos] = name
      player_pos += 1
      j += 1
    end
    start_row = i
    end_row = j-1
    start_col = 0
    while (true)
      val = sheet[start_row][start_col].value
      break if is_result_cell(val)
      start_col += 1
    end

    end_col = start_col
    while(true)
      val = sheet[start_row][end_col].value
      break if !is_result_cell(val)
      end_col += 1
    end
    end_col -= 1
    matches = []
    puts start_row
    puts end_row
    (start_row..end_row).each do |row|
      current_player = normalize_name(sheet[row][1].value.strip)
      (start_col..end_col).each do |col|
        val = sheet[row][col].value
        next if val==-1
        next if val==0
        val = val.strip
        result = val.split("w")
        next if result.size != 2
        opponent = pos_player_mapping[result[0].to_i]
        match_result = (result[1].to_i == 1) ? "W+" : "B+"
        matches.push({black_name: opponent, white_name: current_player, result: match_result})
      end
    end
    [player_pos_mapping, matches, tournament_name]
  end
  private
  def is_result_cell(val)
    return true if val == -1
    return true if val.to_s.split("b").size > 1
    return true if val.to_s.split("w").size > 1
    return false
  end

  def normalize_name(name)
    remove_weird_char(name).mb_chars.unicode_normalize(:nfkd).gsub(/[^\x00-\x7F]/n, '').downcase.to_s
  end
  def remove_weird_char(name)
    name.tr("ÀÁÂÃÄÅàáâãäåĀāĂăĄąÇçĆćĈĉĊċČčÐĐðĎďĐđÈÉÊËèéêëĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħÌÍÎÏìíîïĨĩĪīĬĭĮįİıĴĵĶķĸĹĺĻļĽľĿŀŁłÑñŃńŅņŇňŉŊŋÒÓÔÕÖØòóôõöøŌōŎŏŐőŔŕŖŗŘřŚśŜŝŞşŠšȘșſŢţŤťŦŧȚțÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųŴŵÝýÿŶŷŸŹźŻżŽž","AAAAAAaaaaaaAaAaAaCcCcCcCcCcDdDdDdEEEEeeeeEeEeEeEeEeGgGgGgGgHhHhIIIIiiiiIiIiIiIiIiJjKkkLlLlLlLlLlNnNnNnNnnNnOOOOOOooooooOoOoOoRrRrRrSsSsSsSsSssTtTtTtTtUUUUuuuuUuUuUuUuUuUuWwYyyYyYZzZzZz")
  end

end
