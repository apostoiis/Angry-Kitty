class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
  has_many :events, through: :debts
  # has_many :organisers, class_name: 
  has_and_belongs_to_many :events, through: :debts
  has_many :debts

end
