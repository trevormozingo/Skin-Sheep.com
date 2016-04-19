class Skin < ActiveRecord::Base
    belongs_to:user

    mount_uploader :attachment, AttachmentUploader #lets rails know to use this uploader for this model
    validates :name, presence: true
    validates :description, presence: true
    validates :attachment, presence: true
end
