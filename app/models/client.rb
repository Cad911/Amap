class Client < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :commandes
  has_many :cageots
  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessor :actual_password
attr_accessible :email, :password, :password_confirmation, :remember_me, :genre, :prenom, :nom, :adresse,:ville,:code_postal, :pays, :telephone, :naissance,:newsletter,:point_relai_id,:reset_password_token

end
