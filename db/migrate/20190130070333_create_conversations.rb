class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.references :user, foreign_key: true
      t.datetime :start
      t.jsonb :messages
      t.integer :engagement

      t.timestamps
    end
  end
end
