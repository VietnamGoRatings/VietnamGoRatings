namespace :rating do
  desc "Calculate rating from database"
  task calculate: :environment do
    model_path = Rails.root.join("tmp/model")
    whr = WholeHistoryRating::Base.new(w2: 14)
    Match.order(:date).joins(:black).joins(:white).where(:players => {is_male: 1}, whites_matches: {is_male: 1}).each do |match|
      result = match.result[0]
      days_from_start = Integer(match.date - Date.new(2000,1,1))
      whr.create_game(match.black_id, match.white_id, result, days_from_start, 0)
    end
    whr.iterate(1000)


    women_whr = WholeHistoryRating::Base.new(w2: 14)
    Match.order(:date).joins(:black).joins(:white).where(:players => {is_male: 0}, whites_matches: {is_male: 0}).each do |match|
      result = match.result[0]
      days_from_start = Integer(match.date - Date.new(2000,1,1))
      women_whr.create_game(match.black_id, match.white_id, result, days_from_start, 0)
    end
    women_whr.iterate(1000)
    ActiveRecord::Base.transaction do
      Player.update_all(rating: nil)
      Player.where(is_male: 1).all.each do |player|
        rating_tuple = (whr.ratings_for_player(player.id).last)
        if (rating_tuple != nil) and (rating_tuple.size > 0)
          rating = rating_tuple[1]
          player.rating = rating + 1500
          player.save!
        end
      end

      Player.where(is_male: 0).all.each do |player|
        rating_tuple = (women_whr.ratings_for_player(player.id).last)
        if (rating_tuple != nil) and (rating_tuple.size > 0)
          rating = rating_tuple[1]
          player.rating = rating + 1500
          player.save!
        end
      end
    end
    f = File.open(model_path, "wb")
    f.write(Marshal.dump(whr))
    f.close

  end
end
