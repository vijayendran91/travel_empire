class WhatsappMessage
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :image
  has_mongoid_attached_file :video
  has_mongoid_attached_file :voice

  validates_attachment :image, :content_type => { :content_type => ["application/octet-stream","image/jpg","image/jpeg","image/png"] }
  validates_attachment :video, :content_type => { :content_type => ["application/octet-stream","video/mp4"] }
  validates_attachment :voice, :content_type => { :content_type => ["application/octet-stream","audio/ogg; codecs=opus","video/ogg"] }


  field :phone, type: String
  field :sent_by, type: String
  field :message_type, type: String
  field :text_message, type: String
  field :video, type: String
  field :voice, type: String
  field :document, type: String
  field :location, type: String
  field :timestamp, type: DateTime

  ADMIN = "admin"
  USER = "user"

  TEXT = :text
  VIDEO = :video
  LOCATION = :location
  IMAGE = :image
  VOICE = :voice

  CUSTOMER_BOOKING_CONFIRMATION = :customer_booking_confirmation
  ADMIN_BOOKING_CONFIRMATION = :admin_booking_confirmation
  USER_INITIATED = :user_initiated

  MESSAGE_TYPE = {
    TEXT => "text",
    VIDEO => "video",
    VOICE => "voice",
    LOCATION => "location",
    IMAGE => "image"
  }

  TEMPLATE_MESSAGE = {
    USER_INITIATED => "user_initiated",
    CUSTOMER_BOOKING_CONFIRMATION => "customer_booking_confirmation",
    ADMIN_BOOKING_CONFIRMATION => "admin_booking_confirmation"
  }
end
