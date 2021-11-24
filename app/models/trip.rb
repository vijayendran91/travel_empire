class Trip
  include Mongoid::Document

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
  field :fname, type: String
  field :lname, type: String
  field :phone, type: String
  field :email, type: String
  field :gst, type: String


  PERSONAL = :per
  BUSINESS = :bus

  TRIP_TYPE = { 
                PERSONAL => "Personal",
                BUSINESS => "Business"                
              }
  TRIP_TYPE_REV = TRIP_TYPE.invert

end
