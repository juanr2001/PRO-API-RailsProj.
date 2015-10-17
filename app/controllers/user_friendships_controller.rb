class UserFriendshipsController < ApplicationController
    before_action :authenticate_user!

    def index
        @user_friendships = current_user.user_friendships.all
    end

    def accept
        @user_friendship = current_user.user_friendships.find( params[ :id ] )
        if @user_friendship.accept_mutual_friendship!
            @user_friendship.friend.user_friendships.find_by(friend_id: current_user.id).accept_mutual_friendship!
            flash[ :notice ] = "You are now friends with #{@user_friendship.friend.first_name}"
        else
            flash[ :error ] = "That friendship could not be accepted."
        end
        redirect_to user_friendships_path
    end

    def new
        if params[ :friend_id ]
            @friend = User.where( profile_name: params[ :friend_id ] ).first
            raise ActiveRecord::RecordNotFound if @friend.nil?
            @user_friendship = current_user.user_friendships.new( friend: @friend)
        else
            flash[ :error ] = "Friend required"
        end
    rescue ActiveRecord::RecordNotFound
        render file: 'public/404', status: :not_found
    end

    # def create
    #     @friend = User.where( profile_name: params[:user_friendship][ :friend_id ] ).first
    #     @user_friendship = current_user.user_friendships.build( friend_id: params[:friend_id])
    #     if @user_friendship.save
    #         flash[ :notice ] = "Friend request sent."
    #         redirect_to profile_path(@friend)
    #     else
    #         redirect_to root_path
    #     end
    # end

    def create
        if params[:user_friendship ] && params[ :user_friendship ].has_key?( :friend_id )
            @friend = User.where( profile_name: params[:user_friendship][ :friend_id ] ).first
            @user_friendship = UserFriendship.request( current_user, @friend)
            if @user_friendship.new_record?
                flash[ :error ] = "There was poblem creating that friend request."
            else
                flash[:notice] = "Friend request sent."
            end
            redirect_to profile_path(@friend)
        else
            flash[ :error ] = "Friend required"
            redirect_to root_path
        end
    end

    def edit
        @user_friendship = current_user.user_friendships.find( params[ :id ] )
        @friend = @user_friendship.friend
    end

    def destroy
        @user_friendship = current_user.user_friendships.find( params[ :id ] )

        if @user_friendship.destroy
            flash[:notice] = "Friendship destroyed"
        end
        redirect_to user_friendships_path
    end

    private

    def strong_params
        params.require( :user_friendship).permit( :user_id, :friend_id, :user, :friend )
    end

end
