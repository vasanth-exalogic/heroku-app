class ChangeContactToBeStringInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :contact, :string
    change_column :users, :econtact, :string
  end
end
