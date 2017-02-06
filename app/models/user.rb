class User < ApplicationRecord

  include DateMethods

  # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" },
  #   :url  => "/assets/images/users/:id/:style/:basename.:extension",
  #   :path => ":rails_root/public/assets/images/users/:id/:style/:basename.:extension"
  #validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  before_validation :make_slug, on: :create
  validates_presence_of :slug

  has_many :votes, dependent: :destroy
  has_many :vote_options, through: :votes
  has_many :search_datum, dependent: :destroy
  has_many :polls, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed 
  has_many :followers, through: :passive_relationships, source: :follower
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

  def age
    about_me.age
  end

  def is_private?
    if is_public
      false
    else
      true
    end
  end

  def admin?
    if admin
      true
    else
      false
    end
  end

  def is_private
    is_public == false ? (true) : (false)
  end

  def make_slug
    a = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    string = (0..10).map { a[rand(a.length)] }.join
    self.slug = [string, self.name.downcase.gsub(' ','-')].join("-")
  end

  def to_param
    slug
  end

  def self.messages(id)
    User.joins('INNER JOIN messages m ON users.id = m.id').select('*').where("users.id = #{id}")
  end

  def unread
    messages.where(:read => false).map(&:read).count
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  class << self
  	def from_omniauth(auth)
  	    uid = auth.uid
  	    info = auth.info.symbolize_keys!
  	    user = User.find_or_initialize_by(uid: uid)
        user.email = info.email
  	    user.name = info.name
  	    user.image_url = info.image
  	    user.save!
  	    user
  	end
  end
end
