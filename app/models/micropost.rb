class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope {order('created_at DESC')}
  mount_uploader :picture, PictureUploader
  mount_uploader :video, VideoUploader
  validates :user_id, presence: true
  validates :content, presence: true,length: {maximum: 140}
  validate  :picture_size
  has_many :comments, :dependent => :destroy
  accepts_nested_attributes_for :comments
  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
