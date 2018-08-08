class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|

      ## Database authenticatable
      t.string :email, unique: true
      t.string :encrypted_password

      ## Recoverable
      t.string   :reset_password_token, unique: true
      t.datetime :reset_password_sent_at

      ## Rememberable
      # t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.inet     :current_sign_in_ip
      # t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Omniauthable
      t.string :provider
      t.string :uid, index: true, unique: true
      t.string :authentication_token
      t.datetime :token_expires_at

      t.string :name
      t.string :gplus_profile
      t.string :facebook_profile
      t.string :twitter_profile
      t.string :linkedin_profile
      t.string :phone_number
      t.string :username, index: true, unique: true
      t.references :country, index: true
      t.string :level, index: true
      t.text :description
      t.attachment :profile_pic
      t.jsonb :educations
      t.jsonb :certificates
      t.string :availability_type
      t.integer :expected_income_per_month
      t.string :languages, array: true
      t.string :status, index: true
      t.index [:languages], using: :gin
      t.timestamps null: false
    end
  end
end
