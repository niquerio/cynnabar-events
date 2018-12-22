#force start_date and end_date times
class Event < ApplicationRecord
  belongs_to :meta_event
  has_many :pages
  accepts_nested_attributes_for :pages
  has_many :contacts
  accepts_nested_attributes_for :contacts
  has_many :locations
  accepts_nested_attributes_for :locations

	before_save :set_time_for_start_and_end

  def page(slug)
    self.pages&.find_by(slug: slug)
  end

  def slug
    self.meta_event.slug
  end

  def self.active(slug)
    #TBC will be determined by active flag
    MetaEvent.find_by(slug: slug).events.first
  end

	private
	def set_time_for_start_and_end
		self.start_date = self.start_date&.change(zone: 'EST', hour: 00, min: 00, sec: 00)
		self.end_date = self.end_date&.change(zone: 'EST', hour: 00, min: 00, sec: 00) 
	end
end
