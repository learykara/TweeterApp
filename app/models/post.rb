class Post < ActiveRecord::Base
	belongs_to :user # belongs_to contains foreign key to user_id
	validates_presence_of :content # requires post to have content
end
