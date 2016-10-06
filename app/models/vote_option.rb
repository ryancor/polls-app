class VoteOption < ApplicationRecord

	include DateMethods
	
  	belongs_to :poll
  	validates :title, presence: true
  	has_many :votes, dependent: :destroy
	has_many :users, through: :votes

	def self.search(query)
		where("title LIKE ?", "%#{query}%")
	end
end
