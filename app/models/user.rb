class User < ApplicationRecord

  include DateMethods

  has_many :votes, dependent: :destroy
  has_many :vote_options, through: :votes
  has_many :search_datum, dependent: :destroy
  has_many :polls, dependent: :destroy
  has_one :about_me, dependent: :destroy

  scope :who_voted, -> { joins(:votes).where("vote_option_id IS NOT NULL")
                          .map(&:name).uniq }

  def voted_for?(poll)
  	vote_options.any? {|v| v.poll == poll }
  end

  def voted_questions
  	votes.map(&:vote_option).map(&:poll).map(&:topic)
  end

  def voted_answers
  	votes.map(&:vote_option).map(&:title)
  end

  def how_many_votes
    votes.count
  end

  def has_photo_shown
    if image_url.nil? || image_url.blank?
      return false
    elsif image_url.present? || !image_url.nil?
      return true
    else
      'Nothing Found'
    end
  end

  def has_photo?
    image_url.present?
  end

  def first_name
    name.split(' ',2)[0]
  end

  def last_name
    name.split(' ',2)[1]
  end

  def searched
    search_datum.map(&:value)
  end

  class << self
  	def from_omniauth(auth)
  	    uid = auth.uid
  	    info = auth.info.symbolize_keys!
  	    user = User.find_or_initialize_by(uid: uid)
  	    user.name = info.name
  	    user.image_url = info.image
  	    user.save!
  	    user
  	end
  end
end
