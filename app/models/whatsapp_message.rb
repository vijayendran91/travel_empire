class WhatsappMessage
  include Mongoid::Document
  include Mongoid::Paperclip

  field :phone, type: String
  field :sent_by, type: String
  field :message_type, type: String
  field :text_message, type: String
  field :image, type: String
  field :video, type: String
  field :voice, type: String
  field :location, type: String
  field :timestamp, type: DateTime


  ADMIN = "admin"
  USER = "user"

  TEXT = :text
  VIDEO = :video
  LOCATION = :location

  CUSTOMER_BOOKING_CONFIRMATION = :customer_booking_confirmation
  ADMIN_BOOKING_CONFIRMATION = :admin_booking_confirmation

  MESSAGE_TYPE = {
    TEXT => "text",
    VIDEO => "video",
    LOCATION => "location"
  }

  TEMPLATE_MESSAGE = {
    CUSTOMER_BOOKING_CONFIRMATION => "customer_booking_confirmation",
    ADMIN_BOOKING_CONFIRMATION => "admin_booking_confirmation"
  }
end
