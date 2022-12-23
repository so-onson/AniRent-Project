class User < ApplicationRecord
  has_secure_password
  has_many :customers, dependent: :destroy
  has_many :managers

  validates :email, presence: true, format: { with: /[A-Za-z]+@[A-Za-z]+.[A-Za-z]+/, message: 'Incorrect email'}, on: [:create]
  validates :first_name, presence: true
  validates :password, presence: true, :length => { :minimum => 6,  message: 'Please, input 6 minimum' }, on: [:create]
  validates :role, presence: true

  def admin?
    role == 'admin'
  end

  def manager?
    role == 'manager' || role == 'admin'
  end

  def custom?
    role == 'custom' 
  end

  

  enum role: [ :custom, :manager, :admin ]
end
