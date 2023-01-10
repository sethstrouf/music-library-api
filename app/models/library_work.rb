class LibraryWork < ApplicationRecord
  include PgSearch::Model

  auto_strip_attributes :index, :quantity, :last_performed

  belongs_to :work
  belongs_to :library

  scope :sort_by_work_title, -> { joins(:work).order('works.title ASC') }

  pg_search_scope :search,
    associated_against: {
      work: [:title, :composer, :arranger, :editor, :lyricist, :genre,
      :text, :publisher, :publishing_year, :duration, :tempo, :season,
      :ensemble, :voicing, :instrumentation, :difficulty]
    },
    using: {
      tsearch: {
        prefix: true,
        any_word: true
      }
    }
end
