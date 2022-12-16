class CreateRecommends < ActiveRecord::Migration[6.1]
  def change
    create_table :recommends do |t|
      t.string :youtube_url
      t.text :recommend_about

      t.timestamps
    end
  end
end
