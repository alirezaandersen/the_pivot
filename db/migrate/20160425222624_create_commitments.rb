class CreateCommitments < ActiveRecord::Migration
  def change
    create_table :commitments do |t|
      t.references :volunteer, index: true, foreign_key: true
      t.references :task, index: true, foreign_key: true
    end
  end
end
