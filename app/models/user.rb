class User < ApplicationRecord
    has_one :login

    has_many :reviews
    has_many :products, through: :reviews

    has_secure_password
    validates :password, :confirmation => true
    validates :password, presence: true
    
    validates :username, presence: true 
    validates :username, uniqueness: true 

    def logged_in?
        session[:user_id] == self.id 
    end

    # def self.find_or_create_from_auth_hash(auth)
	# 	where(provider: "Google", uid: auth.uid).first_or_initialize.tap do |user|
	# 		user.provider = "Google"
	# 		user.uid = auth.uid
	# 		user.first_name = auth.info.first_name
	# 		user.last_name = auth.info.last_name
	# 		user.email = auth.info.email
	# 		user.picture = auth.info.image
	# 		user.save!
	# 	end
    # end
    
    # def self.sign_in_from_omniauth(auth)
    #     find_by(provider: auth['provider'], uid: auth['uid']) || create_user_from_omniauth(auth)
    # end

    # def self.create_user_from_omniauth(auth)
    #     create(
    #         provider: auth['provider'],
    #         uid: auth['uid'],
    #         name: auth['info']['name']
    #     )
    # end

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
          user.email = auth.info.email
          user.uid = auth.uid
          user.provider = auth.provider
          user.avatar_url = auth.info.image
          user.username = auth.info.name
          user.oauth_token = auth.credentials.token
          user.save!
        end
    end



end
