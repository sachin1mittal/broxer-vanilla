class CreateSkillsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :skills_users do |t|
      t.references :user, index: true
      t.references :skill, index: true
      t.string :level
    end
  end
end
