class AboutMe < ApplicationRecord

  include DateMethods

  belongs_to :user

  def last_updated?
  	updated_when
  end

  def last_updated
  	updated_at.strftime("%m/%d/%Y")
  end

  def update_counter
  	update_count + 1
  end

  def bad_words?
    if AboutMe.check_bad_words.index{ |x| bio.include?(x) }.present?
      if bio.split(' ').include?(AboutMe.check_bad_words) == false
        return true
      end
    end
  end

  def self.check_bad_words
    bad_words = "fuck fucker hoes hoe bitch slut asshole ass dumb dumbass kill murder rape shit stupid"
    bad_words = bad_words.split(' ')
  end
end
