class AddAttachmentImgToMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.attachment :img
    end
  end

  def self.down
    remove_attachment :messages, :img
  end
end
