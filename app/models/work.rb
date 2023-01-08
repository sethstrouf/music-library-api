class Work < ApplicationRecord
  include PgSearch::Model

  enum :duration, {
    zero_to_two: 'zero_to_two',
    two_to_four: 'two_to_four',
    four_to_six: 'four_to_six',
    six_to_ten: 'six_to_ten',
    ten_to_twenty: 'ten_to_twenty',
    twenty_to_sixty: 'twenty_to_sixty',
    sixty_plus: 'sixty_plus'
  }, suffix: true

  enum :tempo, {
    very_slow: 'very_slow',
    slow: 'slow',
    medium: 'medium',
    fast: 'fast',
    very_fast: 'very_fast',
  }, suffix: true

  enum :genre, {
    folk: 'folk',
    patriotic: 'patriotic',
    cultural: 'cultural',
    march: 'march',
    classical: 'classical',
    modern: 'modern',
    theater: 'theater',
    spiritual: 'spiritual',
    holiday: 'holiday'
  }

  enum :season, {
    fall: 'fall',
    winter: 'winter',
    spring: 'spring',
    graduation: 'graduation'
  }, suffix: true

  enum :ensemble, {
    choir: 'choir',
    band: 'band',
    jazz_band: 'jazz_band',
    marching_band: 'marching_band',
    pep_band: 'pep_band',
    orchestra: 'orchestra',
    vocal_chamber: 'vocal_chamber',
    instrumental_chamber: 'instrumental_chamber',
    string_chamber: 'string_chamber'
  }, suffix: true

  enum :voicing, {
    unison: 'unison',
    sa: 'sa',
    ssa: 'ssa',
    ssaa: 'ssaa',
    sab: 'sab',
    sat: 'sat',
    satb: 'satb',
    tb: 'tb',
    ttbb: 'ttb',
    ssaattbb: 'ssaattbb'}, prefix: true

  enum :instrumentation, {
    woodwinds: 'woodwinds',
    brass: 'brass',
    percussion: 'percussion',
    strings: 'strings',
  }, prefix: true

  enum :difficulty, {
    very_easy: 'very_easy',
    easy: 'easy',
    medium: 'medium',
    difficult: 'difficult',
    very_difficult: 'very_difficult',
  }, suffix: true

  validate :composer_or_arranger

  auto_strip_attributes :title, :composer
  auto_strip_attributes :genre, :publishing_year, squish: true

  has_one_attached :image, dependent: :destroy

  has_many :library_works, dependent: :destroy

  after_save :set_image_url

  pg_search_scope :search,
    against: [
      [:title, 'A'],
      [:composer, 'B'],
      [:arranger, 'B'],
      [:editor, 'B'],
      [:lyricist, 'C'],
      [:genre, 'C'],
      :text, :publisher, :publishing_year, :duration, :tempo, :season,
      :ensemble, :voicing, :instrumentation, :difficulty
    ],
    using: {
      tsearch: {
        prefix: true,
        any_word: true
      }
    }

  def set_image_url
    if self.image.present?
      if ENV['RAILS_ENV'] == 'production'
        new_image_url = self.image.url
        self.update!(image_url: new_image_url) if self.image_url != new_image_url
      else
        blob_path = "http://localhost:3000/#{Rails.application.routes.url_helpers.rails_blob_path(self.image, only_path: true)}"
        self.update!(image_url: blob_path) if self.image_url != blob_path
      end
    end
  end

  private

    def composer_or_arranger
      if composer.blank? && arranger.blank?
        errors.add(:composer, "must be present if no arranger") if composer.blank?
        errors.add(:arranger, "must be present if no composer") if arranger.blank?
      end
    end
end
