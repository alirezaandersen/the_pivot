class ChangeDefaultForSubmissionsApproval < ActiveRecord::Migration
  def change
    change_column :submissions, :approval, :integer, :default => 0
  end
end
