class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.datetime :date
      t.string :type

      t.timestamps
    end
  end
end
