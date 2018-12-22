namespace :data do
  task :users => :environment do
    user = User.create(email: 'nique.rio@gmail.com', password: 'password')
  end
  task :event_series => :environment do
    t = MetaEvent.create(name: 'Terpsichore at the Tower', slug: 'terp')
    Event.create do |u|
      u.name = 'Terpsichore at the Tower XX'
      u.start_date =  Date.parse('01-Dec-2020')
      u.end_date = Date.parse('02-Dec-2020')
      u.meta_event = t
    end
    g = MetaEvent.create(name: 'Grand Day of Tournaments', slug: 'gdot')
    Event.create do |u|
      u.name = 'Grand Day of Tournaments XX'
      u.start_date =  Date.parse('01-May-2020')
      u.end_date = Date.parse('02-May-2020')
      u.meta_event = g
    end
  end
  task :all => ['db:reset', :users, :event_series]    
  end
