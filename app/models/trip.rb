class Trip
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :photoproof1
  has_mongoid_attached_file :photoproof2
  validates_attachment :photoproof1, :presence => true, :size => { :in => 0..5.megabytes }
  validates_attachment_content_type :photoproof1, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :photoproof2, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


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
end
