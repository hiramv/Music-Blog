class Post < ActiveRecord::Base
	rolify
	belongs_to :user
end
