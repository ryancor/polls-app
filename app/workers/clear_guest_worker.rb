class ClearGuesttWorker
	include Sidekiq::Worker

	if !Rails.env.production?
		include Sidetiq::Schedulable

		recurrence do
			daily.hour_of_day(16)
		end
	end

	def perform(msg)
		# add worker to clear nil guest users
	end
end