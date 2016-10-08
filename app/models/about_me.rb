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
end
