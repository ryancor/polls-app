class Vote < ApplicationRecord

  include DateMethods

  belongs_to :user
  belongs_to :vote_option

  counter_culture :vote_option

  def voted_when?
  	vote_option.created_when
  end
end
