class AddAttachmentPhotoproof1ToTrips < ActiveRecord::Migration
  def self.up
    change_table :trips do |t|
      t.attachment :photoproof1
    end
  end

  def self.down
    remove_attachment :trips, :photoproof1
  end
end
