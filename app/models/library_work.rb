class LibraryWork < ApplicationRecord
  auto_strip_attributes :index, :quantity, :last_performed

  belongs_to :work
  belongs_to :library
end
