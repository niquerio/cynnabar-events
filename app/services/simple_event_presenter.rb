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
end
