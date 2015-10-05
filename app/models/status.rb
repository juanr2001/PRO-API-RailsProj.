class Status < ActiveRecord::Base

    # Association
    belongs_to :user

    #Validation
    validates :content, presence: true,
                                length: { minimum: 2,
                                                message: "Content must be more than 2 characters"
                                            }

    validates :user_id, presence: true
end
