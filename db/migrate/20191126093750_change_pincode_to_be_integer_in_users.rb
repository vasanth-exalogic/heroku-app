class ChangePincodeToBeIntegerInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :pincode, :integer
  end
end
