class Work < ApplicationRecord
  has_many :library_works, dependent: :destroy
end
