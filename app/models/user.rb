# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  username                     :string(255)      not null
#  email                        :string(255)
#  crypted_password             :string(255)
#  salt                         :string(255)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  remember_me_token            :string(255)
#  remember_me_token_expires_at :datetime
#  prestador_id                 :integer
#  admin_id                     :integer
#  institucion_user_id          :integer
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :email, :password, :password_confirmation

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_confirmation_of :password

  validates :username, uniqueness: true, presence: true#, length: { minimum: 6, maximum: 16 }
  validates :email, format: { with: VALID_EMAIL_REGEX }, presence: true
  # Validar que el password esté presente cuando se crea un usuario
  validates :password, length: { minimum: 6, maximum: 16 }, presence: true, on: :create
  # Validar lo siguiente solo cuando se actualiza
  validates :password, length: { minimum: 6, maximum: 16 }, if: :password, on: :update

  before_save { self.email.downcase! }

  # Relaciones
  belongs_to :prestador, dependent: :destroy
  belongs_to :admin
  belongs_to :institucion_user


  def user_page
    if self.prestador
      '/prestador/home'
    elsif self.admin
      '/admin/home'
    elsif self.institucion_user
      '/institucion/home'
    end
  end

end