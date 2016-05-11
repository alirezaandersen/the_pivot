class RemoveCommitments < ActiveRecord::Migration
  def change
    drop_table :commitments
  end
end
