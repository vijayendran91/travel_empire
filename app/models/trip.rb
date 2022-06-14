class Trip
  include Mongoid::Document
  include Mongoid::Paperclip

  belongs_to :whatsapp_number

  has_one :driver_module
  has_mongoid_attached_file :photoproof1
  has_mongoid_attached_file :photoproof2
  validates_attachment :photoproof1, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "application/pdf"] }
  validates_attachment :photoproof2, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "application/pdf"] }

  attr_accessor :cc

  attr_accessor :start_date, :end_date
  field :perbus, type: String
  field :tot, type: String
  field :adult, type: Integer
  field :chldrn, type: Integer
  field :pul, type: String
  field :pua, type: String
  field :put, type: DateTime
  field :drl, type: String
  field :dra, type: String
  field :drt, type: DateTime
  field :tob, type: String
  field :str, type: String
  field :fname, type: String
  field :lname, type: String
  # field :cc, type: String
  field :phone, type: String
  field :email, type: String
  field :gst, type: String
  field :gst_lg_nm, type: String
  field :gst_full_addr, type: String
  field :tick, type: String
  field :locs1, type: String
  field :locs2, type: String
  field :locs3, type: String
  field :locs4, type: String
  field :msg, type: String
  field :created_at , type: DateTime
  field :trp_sts, type: String
  field :hrt, type: Integer
  PERSONAL = :per
  BUSINESS = :bus

  TRIP_TYPE = {
                PERSONAL => "Personal",
                BUSINESS => "Business"
              }
  TRIP_TYPE_REV = TRIP_TYPE.invert

  ONE_WAY = :ow
  MULTI_WAY = :my
  HOURLY = :hy
  RETURN_TRIP = :rtt
  ROUND_TRIP = :rt

  TYPE_OF_TRIP = {
                  ONE_WAY => "One Way",
                  MULTI_WAY => "Multi Way",
                  HOURLY => "Hourly",
                  RETURN_TRIP => "Return Trip",
                  ROUND_TRIP => "Round Trip"
                }
  TYPE_OF_TRIP_REV = TYPE_OF_TRIP.invert

  TRIP_BOOKED = :trip_booked
  TRIP_STARTED = :trip_started
  TRIP_COMPLETE = :trip_complete
  TRIP_CANCELED = :trip_canceled

  TRIP_STATUS = {
    TRIP_BOOKED => "Trip Booked",
    TRIP_STARTED => "Trip Started",
    TRIP_COMPLETE => "Trip Complete",
    TRIP_CANCELED => "Trip Canceled"
  }

  TRIP_STATUS_REV = TRIP_STATUS.invert
end
