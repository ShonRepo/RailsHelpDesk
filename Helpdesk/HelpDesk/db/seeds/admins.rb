
if Admin.count.zero?
  puts 'Seeding Admin'
  Admin.create!(last_name: 'admin', first_name: 'admin', email:'admin@admin.ru',password:'123qweasd',password_confirmation: '123qweasd')
  puts 'Seeding Admin'
end
