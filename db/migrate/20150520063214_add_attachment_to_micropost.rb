class AddAttachmentToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :attachment, :string
  end
end
