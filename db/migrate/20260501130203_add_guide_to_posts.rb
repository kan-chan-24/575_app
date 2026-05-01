class AddGuideToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :guide, :string
  end
end
