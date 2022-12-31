class Library < ApplicationRecord
  auto_strip_attributes :name

  belongs_to :user
  has_many :library_works, dependent: :destroy
end
