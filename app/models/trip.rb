class Trip
  include Mongoid::Document

  field :fname, type: String
  field :lname, type: String
end
