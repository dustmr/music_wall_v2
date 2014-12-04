class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :track
      t.belongs_to :user
      t.text :comment_body
      t.timestamps
    end
  end
end
