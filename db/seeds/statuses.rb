if Status.count.zero?
  puts 'Seeding Statuses'
  %w(Новый Обработка Завершен).each do |name|
    Status.create(name: name)
  end
end
