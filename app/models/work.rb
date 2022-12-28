class Work < ApplicationRecord
  include PgSearch::Model

  has_many :library_works, dependent: :destroy

  pg_search_scope :search,
    against: {
      title: 'A',
      composer: 'B',
      genre: 'C',
      publishing_year: 'D'
    },
    using: {
      tsearch: {
        prefix: true,
        any_word: true
      }
    }
end
