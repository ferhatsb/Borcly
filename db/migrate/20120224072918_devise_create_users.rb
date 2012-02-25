class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|

      t.string :email, :default => ""
      t.string :user_name, :default => ""
      t.boolean :first_time, :default => true

      t.timestamps
    end
  end
end
