class RemoveTypeFromNotification < ActiveRecord::Migration[6.0]
  def change
    remove_column :notifications, :type
    add_column :notifications, :notification_type, :string
  end
end
