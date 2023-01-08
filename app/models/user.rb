class User < ApplicationRecord
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

  after_save :set_profile_photo_url

  def name
    "#{first_name} #{last_name}"
  end

  private


  def set_profile_photo_url
    if self.profile_photo.present?
      if ENV['RAILS_ENV'] == 'production'
        new_profile_photo_url = self.profile_photo.url
        self.update!(profile_photo_url: new_profile_photo_url) if self.profile_photo_url != new_profile_photo_url
      else
        blob_path = "http://localhost:3000/#{Rails.application.routes.url_helpers.rails_blob_path(self.profile_photo, only_path: true)}"
        self.update!(profile_photo_url: blob_path) if self.profile_photo_url != blob_path
      end
    end
  end
end
