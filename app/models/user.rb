class User < ActiveRecord::Base
  rolify
	has_and_belongs_to_many :roles
	has_many :posts

	def role?(role)
      return !!self.roles.find_by_name(role.to_s.camelize)
  	end

  	def self.from_omniauth(auth)
  		where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
	end

	def self.create_from_omniauth(auth)
  		create! do |user|
    		user.provider = auth["provider"]
    		user.uid = auth["uid"]
    		user.name = auth["info"]["nickname"]
  		end
	end
end
