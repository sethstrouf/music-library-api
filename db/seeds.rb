# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

25.times do |i|
  User.create!(first_name: "First#{i}", last_name: "Last#{i}", email: "first#{i}@example.com", password: 'TESTpassword555!')
end

user = User.create!(first_name: 'Seth', last_name: 'Strouf', email: 'seth@mail.com', password: 'asdfASDF123!')

library = user.libraries.create!(name: "Seth's Choir Library")
user.libraries.create!(name: "Seth's Band Library")
user.libraries.create!(name: "Seth's Orchestra Library")

25.times do |i|
  work = Work.create!(title: "Title #{i}", composer: "Composer #{i}", genre: 'Holiday', publishing_year: 1950 + i)
  library.library_works.create!(index: i+500, work: work, quantity: i + 60, last_performed: Date.today - i.months)
end
