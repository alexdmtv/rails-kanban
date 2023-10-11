class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable
  devise :omniauthable, omniauth_providers: %i[github]

  has_many :boards, dependent: :destroy
  has_many :lists, through: :boards
  has_many :tasks, through: :lists
  has_many :subtasks, through: :tasks

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_save { self.email = email.downcase }

  def self.from_omniauth(auth)
    user = where('email = ? or (provider = ? and uid = ?)', auth.info.email, auth.provider,
                 auth.uid).first_or_initialize

    if user.new_record?
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
      user.save!
    else
      user.provider = auth.provider
      user.uid = auth.uid
      user.save!
    end

    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.github_data'] && session['devise.github_data']['extra']['raw_info']) && user.email.blank?
        user.email = data['email']
      end
    end
  end
end
