class AddImageToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :image, :string
  end
end
