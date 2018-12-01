class Prefriendship < ActiveRecord::Base
    belongs_to :user
    belongs_to :prefriend, :class_name => "User"
end
