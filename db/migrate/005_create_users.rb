class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :encrypted_password
      t.string :provider, index: true
      t.string :pre_token
      t.boolean :seller

      t.string :name
      t.string :gplus_profile
      t.string :facebook_profile
      t.string :twitter_profile
      t.string :linkedin_profile
      t.string :username, index: true, unique: true
      t.references :country, index: true
      t.text :description
      t.attachment :profile_pic
      t.jsonb :educations
      t.jsonb :certificates
      t.string :availability_type, index: true
      t.string :languages, array: true
      t.string :status, index: true
      t.decimal :wallet_balance, default: 0.0
      t.index [:languages], using: :gin
      t.timestamps null: false
    end
  end
end
