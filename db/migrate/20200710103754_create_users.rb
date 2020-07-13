class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.float :cash_balance
      t.timestamps
    end
    # for SQLITE
    execute "UPDATE SQLITE_SEQUENCE SET seq = 1000 WHERE name = 'users'"
  end
end
