class Event < ApplicationRecord
  belongs_to :meta_event
  has_many :pages
  accepts_nested_attributes_for :pages

  def page(slug)
    self.pages&.find_by(slug: slug)
  end
end
