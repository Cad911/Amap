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


	def mes_commandes
		@commandes = Commande.where('client_id = ? AND etat = "paye"', self.id)
		
		return @commandes
	end
	
	def tous_mes_abonnements
		@abonnements = Abonnement.where('client_id = ? AND etat="paye"',self.id)
		
		return @abonnements
	end
	
	def mes_abonnements_en_cours
		  @today = Date.today
		  @abonnements = Abonnement.where('client_id = ? AND etat="paye" AND date_fin >= ?', self.id, @today)
			#______ EN COURS ACTUELLEMENT ______________
		  return @abonnements
	end
	
	def mes_abonnements_termines
		@today = Date.today
		@abonnements = Abonnement.where('client_id = ? AND etat="paye" AND date_fin < ?',self.id,@today)

		return @abonnements
	end
end
