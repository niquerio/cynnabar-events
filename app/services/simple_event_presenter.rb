class SimpleEventPresenter
  extend Forwardable
	def_delegators :@event, :name, :id, :facebook_event_link

	def initialize(event)
		@event = event
	end
	def date
		if @event.start_date.nil?
			'TBD'
		elsif @event.start_date == @event.end_date
			@event.start_date.strftime("%A, %B %-d, %Y")
		elsif @event.start_date.year == @event.end_date.year
			"#{@event.start_date.strftime("%A, %B %-d")} - #{@event.end_date.strftime("%A, %B %-d, %Y")}"
	  else
			"#{@event.start_date.strftime("%A, %B %-d, %Y")} - #{@event.end_date.strftime("%A, %B %-d, %Y")}"
		end
	end
	def contact
		@event.contacts&.first if @event.contacts&.first&.name.present? && @event.contacts&.first&.email.present?
	end
	def description
		@event.page('description')&.body
	end
	def pages
		order = ['gate','schedule','food','info']
		order.map{ |s| @event.page(s) if @event.page(s)&.body&.present? }.compact
	end
	def location
		loc = @event.locations.first
		if loc.nil? || (loc.name.blank? && loc.address.blank?)
			'TBD'
		else
		 [loc.name, loc.address].map{|l| l if l.present?}.compact.join(', ')	
		end
	end
end
