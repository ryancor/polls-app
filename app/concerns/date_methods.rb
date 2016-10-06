module DateMethods
	def created_when
		t = Time.current
		days_old = (t) - (created_at)
		day = (days_old/86400).to_i
		return "less than a day ago" unless day >= 1
		return "#{day} day(s) ago."
	end
end