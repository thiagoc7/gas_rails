class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)

    where(email: auth.info.email).first do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
    end
  end
end
