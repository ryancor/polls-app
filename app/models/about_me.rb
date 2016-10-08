class AboutMe < ApplicationRecord

  include DateMethods

  belongs_to :user

  def last_updated?
  	updated_when
  end

  def last_updated
  	updated_at.strftime("%m/%d/%Y")
  end
end
