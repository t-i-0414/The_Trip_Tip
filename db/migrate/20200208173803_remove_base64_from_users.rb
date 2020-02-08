class RemoveBase64FromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :base64, :string
  end
end
