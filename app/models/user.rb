class User < ActiveRecord::Base

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
                :recoverable, :rememberable, :trackable, :validatable


#Associations
    has_many :statuses
    has_many :user_friendships
    has_many :friends, -> { where(user_friendships: { state: 'accepted'})}, through: :user_friendships, source: :friend


    has_many :pending_user_friendships,  -> { where state: 'pending' }, class_name:"UserFriendship", foreign_key: :user_id

     has_many :pending_friends, through: :user_friendships, source: :friend


# #this might create a bug
#      has_many :pending_friends,
#               -> { where user_friendships: { state: "pending" } },
#                  through: :user_friendships,
#                  source: :friend

#---------------------------------------#

# Validations
    validates :first_name,
                    :last_name,  presence: true

    validates :profile_name,  presence: true,
                                            uniqueness: true,
                                            format: {

                                                            with: /\A[a-zA-Z0-9_-]+\z/,
                                                            message: "Must be formatted correctly."

                                                        }

#---------------------------------------#

    def full_name
        first_name + " " + last_name
    end

    # def self.get_gravatars
    #     all.each do |user|
    #         if !user.avatar?
    #             user.avatar = URI.parse(user.gravatar_url)
    #             user.save
    #             print "."
    #         end
    #     end
    # end

    def gravatar_url
        stripped_email = email.strip
        downcased_email = stripped_email.downcase
        hash = Digest::MD5.hexdigest(downcased_email)
        "http://gravatar.com/avatar/#{hash}"
    end
    #automatically, rails thing..return the profile name.
    # http://api.rubyonrails.org/classes/ActiveModel/Conversion.html
    def to_param
        profile_name
    end

end
