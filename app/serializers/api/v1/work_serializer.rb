class Api::V1::WorkSerializer
  include JSONAPI::Serializer

  attributes :title, :composer, :arranger, :editor, :lyricist, :genre,
             :text, :publisher, :publishing_year, :language, :duration, :tempo,
             :season, :ensemble, :voicing, :instrumentation, :difficulty, :image_url
end
