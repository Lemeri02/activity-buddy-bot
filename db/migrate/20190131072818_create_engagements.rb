class CreateEngagements < ActiveRecord::Migration[5.2]
  def change
    create_table :engagements do |t|
      t.integer :user_id
      t.integer :message_id
      t.integer :conversation_id
      t.string :strategy
      t.integer :score
      t.jsonb :metrics

      t.timestamps
    end
  end
end
