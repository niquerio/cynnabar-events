class EditEventPresenter
  extend Forwardable
  def_delegators :@event, :name, :id, :model_name, :facebook_event_link, :pages, :pages_attributes=, :page,
    :contacts, :contacts_attributes=, :locations, :locations_attributes=
  def initialize(event)
    @event = event
    @pages = [
      { slug: 'description', title: 'Description'},
      { slug: 'gate', title: 'Gate'},
      { slug: 'schedule', title: 'Schedule'},
      { slug: 'food', title: 'Food'},
      { slug: 'info', title: 'Info'},
    ]
    build_pages
    @event.contacts.build(job: 'Event Steward') if @event.contacts.count < 1
    @event.locations.build if @event.locations.count < 1
  end
  def start_date
    @event.start_date&.strftime('%-d-%b-%Y')  
  end
  def end_date
    @event.end_date&.strftime('%-d-%b-%Y')  
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

