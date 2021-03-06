class SearchDatum < ApplicationRecord
  belongs_to :user
  validates :value, presence: true

  def self.many_users?
  	all.map(&:user).compact.uniq.count
  end

  def self.many_guests?
  	all.map(&:user).reject(&:present?).count
  end

  def self.common_searches?
  	word = SearchDatum.all.map(&:value)
  	result = word.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
  		.map { |k, v| [k.downcase, v] }
  	final = result.max_by(4, &:last)
  	final.inject({}){|x,y| x[y[0]] = y[1..-1]; x}.map(&:flatten)
  end

  def self.search_exists(value)
  	s = SearchDatum.all.map(&:value)
  	s.include?(value) == true ? (true) : (false)
  end
end
