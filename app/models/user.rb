class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :confirmable
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :tasks
end
