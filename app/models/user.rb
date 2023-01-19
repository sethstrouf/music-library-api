class User < ApplicationRecord
  include PgSearch::Model

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  enum :membership, {
    free: 'free',
    individual: 'individual',
    organization: 'organization'
  }, suffix: true

  has_one_attached :profile_photo, dependent: :destroy

  has_many :libraries, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
  foreign_key: "followed_id",
  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  after_save :set_profile_photo_url

  pg_search_scope :search,
    against: [
      [:first_name, 'A'],
      [:last_name, 'B'],
      [:email, 'C'],
    ],
    using: {
      tsearch: {
        prefix: true,
        any_word: true
      }
    }

  def name
    "#{first_name} #{last_name}"
  end

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

    def set_profile_photo_url
      if self.profile_photo.present?
        if ENV['RAILS_ENV'] == 'production'
          new_profile_photo_url = self.profile_photo.url.split(/\?/, 2).first
          self.update!(profile_photo_url: new_profile_photo_url) if self.profile_photo_url != new_profile_photo_url
        else
          blob_path = "http://localhost:3000/#{Rails.application.routes.url_helpers.rails_blob_path(self.profile_photo, only_path: true)}"
          self.update!(profile_photo_url: blob_path) if self.profile_photo_url != blob_path
        end
      end
    end
end
