if Operator.where(id: 0).count.zero?
  puts 'Seeding Operator'
  Operator.create!(id: 0, last_name: 'заполнено', first_name: 'не', email:'empty@empty.ru',password:'123qweasd',password_confirmation: '123qweasd')
  puts 'Seeding Operator'
end
