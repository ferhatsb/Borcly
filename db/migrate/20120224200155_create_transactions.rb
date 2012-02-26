class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :related_person_name
      t.string :related_person_email
      t.string :related_person_twitter
      t.string :related_person_facebook
      t.string :status
      t.float :amount
      t.date :end_date
      t.date :start_date
      t.integer :user_id
      t.boolean :notified
      t.timestamps
    end
  end
end
