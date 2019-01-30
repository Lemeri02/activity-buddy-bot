class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :conversation
      t.text :text
      t.text :answer
      t.datetime :time
      t.jsonb :intents

      t.timestamps
    end
  end
end
