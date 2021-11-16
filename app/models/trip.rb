class Trip
  include Mongoid::Document

  field :perbus, type: String
  field :tot, type: String
  field :adult, type: String
  field :chldrn, type: String
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
end
