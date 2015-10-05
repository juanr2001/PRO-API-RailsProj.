class AddUserIdToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :user_id, :integer
    #find the user based on the status
    # add_index :statuses, :user_id
    remove_column :statuses, :name
  end
end
