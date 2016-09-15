class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :recoverable, :rememberable, :trackable, :validatable  and :omniauthable
  devise :database_authenticatable, :timeoutable
         
end