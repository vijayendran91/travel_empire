class WhatsappMessage
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :image
  has_mongoid_attached_file :video
  has_mongoid_attached_file :voice
  has_mongoid_attached_file :document

  validates_attachment :image, :content_type => { :content_type => ["application/octet-stream","image/jpg","image/jpeg","image/png"] }
  validates_attachment :video, :content_type => { :content_type => ["application/octet-stream","video/mp4"] }
  validates_attachment :voice, :content_type => { :content_type => ["application/octet-stream","audio/ogg; codecs=opus","video/ogg"] }
  validates_attachment :document, :content_type => { :content_type => ["application/octet-stream", "application/msword","application/pdf"] }

  field :phone, type: String
  field :sent_by, type: String
  field :message_type, type: String
  field :text_message, type: String
  field :video, type: String
  field :voice, type: String
  field :document, type: String
  field :location, type: Hash
  field :timestamp, type: DateTime

  before_destroy :clear_media

  ADMIN = "admin"
  USER = "user"

  TEXT = :text
  VIDEO = :video
  LOCATION = :location
  IMAGE = :image
  VOICE = :voice
  DOCUMENT = :document

  CUSTOMER_BOOKING_CONFIRMATION = :customer_booking_confirmation_new
  EDIT_BOOKING_CONFIRMATION = :edit_booking_message
  ADMIN_BOOKING_CONFIRMATION = :admin_booking_confirmation_new
  USER_INITIATED = :user_initiated
  CONVERSATION = :conversation
  DELAY_CONV_REGRET = :delay_conv_regret

  MESSAGE_TYPE = {
    TEXT => "text",
    VIDEO => "video",
    VOICE => "voice",
    LOCATION => "location",
    IMAGE => "image",
    DOCUMENT => "document"
  }

  TEMPLATE_MESSAGE = {
    USER_INITIATED => "user_initiated",
    CUSTOMER_BOOKING_CONFIRMATION => "customer_booking_confirmation_new",
    ADMIN_BOOKING_CONFIRMATION => "admin_booking_confirmation_new",
    CONVERSATION => "conversation",
    EDIT_BOOKING_CONFIRMATION => "edit_booking_message",
    DELAY_CONV_REGRET => "delay_conv_regret"
  }


  #TODO Clear the media from S3 as well
  #https://stackoverflow.com/questions/43176604/paperclip-not-deleting-images-from-s3-on-destroy
  def clear_media

  end
end
