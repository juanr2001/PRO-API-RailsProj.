class UserFriendship < ActiveRecord::Base
    belongs_to :user
    belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
    # attr_accessible :user, :friend, :user_id, :friend_id, :state
    # STATE-MACHINE
    # attr_protected :state_event
    after_destroy :delete_mutual_friendship!
    state_machine :state, initial: :pending do
        after_transition on: :accept, do: [ :send_acceptance_email, :accept_mutual_friendship! ]

        state :requested

        event :accept do
            transition any => :accepted
        end
    end



    #class method start withs self
    def self.request(user1, user2)
        transaction do
        #I can user create because is a class method
            friendship1 = create!( user: user1, friend: user2, state: 'pending' )
            friendship2 = create!( user: user2, friend: user1, state: 'requested' )

            friendship1.send_request_email
            friendship1
        end
    end

    def send_request_email
        UserNotifier.friend_requested( id ).deliver_now
    end

    def send_acceptance_email
        UserNotifier.friend_request_accepted( id ).deliver_now
    end

    def mutual_friendship
        self.class.where( { user_id: friend_id, friend_id: user_id } ).first
    end

    def accept_mutual_friendship!
        #Grab the mutual friendship and update the state without using
        #the state machines so as not to invoke callbacks.
        mutual_friendship.update_attribute( :state, "accepted")
    end

    def delete_mutual_friendship!
        mutual_friendship.delete
    end
end
