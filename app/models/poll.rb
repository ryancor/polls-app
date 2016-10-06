require 'elasticsearch/model'

class Poll < ApplicationRecord
	#include Elasticsearch::Model
    #include Elasticsearch::Model::Callbacks
    include DateMethods

	has_many :vote_options, dependent: :destroy
	has_many :votes, through: :vote_options
	belongs_to :user
	# validates :user, presence: true
	validates :topic, presence: true

	accepts_nested_attributes_for :vote_options, :reject_if => :all_blank, :allow_destroy => true

	def posted_at
		diff_seconds = Time.current.to_i - created_at.to_i
	    case diff_seconds
	    	when 0 .. 59
	     	 	then (diff_seconds).to_s + ' seconds ago'
	    	when 60 .. (3600-1)
	      	 	then (diff_seconds/60).to_s + ' minutes ago'
	      	when 3600 .. (7200 - 1)
	      		then (diff_seconds/3600).to_s + ' hour ago'
	    	when 7200 .. (3600*24-1)
	         	then (diff_seconds/3600).to_s + ' hours ago'
	        when (3600*24) .. (3600*24*2) 
	         	then (diff_seconds/(3600*24)).to_s + ' day ago'
	    	when (3600*24*2) .. (3600*24*30) 
	         	then (diff_seconds/(3600*24)).to_s + ' days ago'
	    	else
	         	created_at.strftime("%m/%d/%Y")
	    end
	end

	def total_choices
		vote_options.count
	end

	def total_votes
		if vote_options.count == 1
			vote_options[0].votes.count
		elsif vote_options.count == 2
			vote_options[0].votes.count +
			vote_options[1].votes.count
		elsif vote_options.count == 3
			vote_options[0].votes.count +
			vote_options[1].votes.count +
			vote_options[2].votes.count
		elsif vote_options.count == 4
			vote_options[0].votes.count +
			vote_options[1].votes.count +
			vote_options[2].votes.count +
			vote_options[3].votes.count
		elsif vote_options.count == 5
			vote_options[0].votes.count +
			vote_options[1].votes.count +
			vote_options[2].votes.count +
			vote_options[3].votes.count +
			vote_options[4].votes.count
		else
			try(:vote_options).count
		end
	end

	def self.who_voted?(s)
		x = find_by_topic s
		x.votes.map(&:user).map(&:name)
	end

	def self.search(query)
		where("topic LIKE ?", "%#{query}%")
	end

	def votes_summary
		vote_options.inject(0) {|summary, option| summary + option.votes.count}
	end

	def normalized_votes_for(option)
		votes_summary == 0 ? 0 : (option.votes.count.to_f / votes_summary) * 100
	end

	def created_by
		user.name
	end
end
