class AddStageToSupports < ActiveRecord::Migration
  def change
    add_column :supports, :stage, :boolean, :default => false
  end

end
