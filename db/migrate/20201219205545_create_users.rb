class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
<<<<<<< HEAD
      t.string :uid
      t.string :provider
=======
>>>>>>> 99c1e6bcee67425da41953b4fa0c4db1ed5869aa
      t.boolean :admin
      t.timestamps
    end
  end
end
