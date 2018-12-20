class Event < ApplicationRecord
  belongs_to :meta_event
  has_many :pages
  accepts_nested_attributes_for :pages
  has_many :contacts
  accepts_nested_attributes_for :contacts
  has_many :locations
  accepts_nested_attributes_for :locations

  def page(slug)
    self.pages&.find_by(slug: slug)
  end
end
