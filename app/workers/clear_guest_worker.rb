class ClearGuestWorker
	include Sidekiq::Worker

	if !Rails.env.production?
		include Sidetiq::Schedulable

		recurrence do
			daily.hour_of_day(16)
		end
	end

	def perform
		search = SearchDatum.where(user_id: nil).last(5)
		search.each do |x|
			5.times do
  				x.delete
  				x.save
  			end
		end
		'5 records of nil searches have been deleted..'
	end
end