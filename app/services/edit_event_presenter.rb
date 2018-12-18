class EditEventPresenter
  extend Forwardable
  def_delegators :@event, :name, :id, :model_name, :facebook_event_link, :pages, :pages_attributes=, :page
  def initialize(event)
    @event = event
    @pages = [
      { slug: 'gate', title: 'Gate'},
      { slug: 'schedule', title: 'Schedule'},
      { slug: 'food', title: 'Food'},
      { slug: 'description', title: 'Description'},
    ]
    build_pages
  end
    
  private
  def build_pages
    @pages.each do |p|
      unless @event.pages.find_by(slug: p[:slug])
        @event.pages.build(slug: p[:slug], title: p[:title])
      end
    end
  end
end

