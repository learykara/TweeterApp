class CreatePosts < ActiveRecord::Migration
  def change
  	# create a table called posts with a content field when you run rake db:migrate
    create_table :posts do |t|
      t.string :content

      t.timestamps
    end
  end
end