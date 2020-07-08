if Status.count.zero?
  puts 'Seeding Statuses'
  i = 1
  %w(Новый Обработка Ожидание Завершен).each do |name|
    Status.create(id: i, name: name)
    i+= 1;
  end
end
