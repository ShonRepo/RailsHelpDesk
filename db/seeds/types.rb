if Type.count.zero?
  puts 'Seeding Types'
  %w(заявка запрос исключение).each do |name|
    Type.create(name: name)
  end
end
