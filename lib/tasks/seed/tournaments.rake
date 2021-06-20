namespace :import do
  desc "Process tournaments data from existing matches table"
  task tournaments: :environment do
    tournament_names = Match.all.pluck(:event).uniq
    tournament_names.each do |name|
      tournament = Tournament.find_or_create_by(name: name)
      Match.where(event: name).update_all(tournament_id: tournament.id)
    end
  end
end
