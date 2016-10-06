class SearchDatum < ApplicationRecord
  belongs_to :user
  validates :value, presence: true

  def self.many_users?
  	all.map(&:user).compact.uniq.count
  end

  def self.many_guests?
  	all.map(&:user).reject(&:present?).count
  end
end
