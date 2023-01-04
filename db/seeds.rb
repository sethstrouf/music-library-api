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

user = User.create!(first_name: 'Seth', last_name: 'Strouf', email: 'seth@mail.com', password: 'asdfASDF123!', admin: true)

choir_library = user.libraries.create!(name: "Seth's Choir Library")
band_library = user.libraries.create!(name: "Seth's Band Library")
orchestra_library = user.libraries.create!(name: "Seth's Orchestra Library")

# Choir
work = Work.create!(title: 'Homeward Bound', composer: 'Marta Keen', arranger: 'Jay Althouse', lyricist: 'Marta Keen', genre: :folk, publisher: 'Alfred Music Publishing', publishing_year: 1996, voicing: :sab, duration: :two_to_four, tempo: :slow, difficulty: :easy)
choir_library.library_works.create!(index: 23, work: work, quantity: 47, last_performed: Date.today - 2.months)

work = Work.create!(title: 'Sisi Ni Moja', composer: 'Jacob Narverud', genre: :cultural, publisher: 'Santa Barbara Music Publishing', publishing_year: 2017, tempo: :medium)
choir_library.library_works.create!(index: 7, work: work, quantity: 30, last_performed: Date.today - 2.months)

work = Work.create!(title: 'O Magnum Mysterium', composer: 'Evan Ramos', genre: :classical, publishing_year: 2016)
choir_library.library_works.create!(index: 85, work: work, quantity: 30, last_performed: Date.today - 2.months)

work = Work.create!(title: 'Bonse Aba', composer: 'Victor C. Johnson', genre: :cultural, publishing_year: 2010)
choir_library.library_works.create!(index: 2, work: work, quantity: 65, last_performed: Date.today - 6.months)

work = Work.create!(title: 'The Seal Lullaby', composer: 'Eric Whitacre', genre: :modern, publishing_year: 2008)
choir_library.library_works.create!(index: 987, work: work, quantity: 65, last_performed: Date.today - 6.months)

work = Work.create!(title: 'Glow', composer: 'Eric Whitacre', genre: :modern, publishing_year: 2013)
choir_library.library_works.create!(index: 1232, work: work, last_performed: Date.today - 6.months)

work = Work.create!(title: 'You Will Be Found', composer: 'Mac Huff', genre: :theater)
choir_library.library_works.create!(work: work, quantity: 1, last_performed: Date.today - 4.months)

work = Work.create!(title: "J'entends le Moulin", composer: 'Emily Crocker', genre: :folk)
choir_library.library_works.create!(work: work)

work = Work.create!(title: 'Stars I Shall Find', composer: 'Victor C. Johnson', publishing_year: 2008)

work = Work.create!(title: 'Shine On Me', composer: 'Rollo Dilworth', genre: :spiritual, publishing_year: 2001)

work = Work.create!(title: 'Let the River Run', composer: 'Craig Hella Johnson')

# Band
work = Work.create!(title: 'Appalachian Morning', composer: 'Robert Sheldon', publishing_year: 2008)
band_library.library_works.create!(work: work, last_performed: Date.today - 3.months)

work = Work.create!(title: 'On a Hymnsong of Philip Bliss', composer: 'David R. Holsinger', publishing_year: 1989)
band_library.library_works.create!(work: work)

work = Work.create!(title: 'First Suite in E Flat', composer: 'Gustav Holst', genre: :classical)

# Jazz Band
work = Work.create!(title: 'The Christmas Song', composer: 'Mark Taylor', genre: :holiday)

work = Work.create!(title: 'Swingle Bells', composer: 'Chris Sharp', genre: :holiday)

work = Work.create!(title: 'Let There Be Peace on Earth', composer: 'Charlie Hill', genre: :holiday, publishing_year: 1983)

# Orchestra
work = Work.create!(title: 'An American in Paris Suite', composer: 'George Gershwin', genre: :classical)
orchestra_library.library_works.create!(work: work)

work = Work.create!(title: 'Carmina Burana', composer: 'Carl Orff', genre: :classical)
orchestra_library.library_works.create!(work: work)

work = Work.create!(title: 'Finlandia', composer: 'Jean Sibelius', genre: :classical)

work = Work.create!(title: '1812 Overture', composer: 'P.I. Tchaikovsky', genre: :classical)

# Solos
work = Work.create!(title: '24 Italian Songs and Arias', composer: 'Various')

work = Work.create!(title: 'The Young Singer', composer: 'Richard D. Row')

work = Work.create!(title: 'The First Book of Baritone/Bass Solos', composer: 'Joan Frey Boytim')
