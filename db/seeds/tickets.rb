if Ticket.count.zero?
  puts 'Seeding Tickets'
  Ticket.create(title: 'test', body: 'test', email:'test')
end
