class WhatsappNumber
  include Mongoid::Document
  has_many :trips
  field :phone, :type=> String
  field :first_name, :type=> String
  field :last_name, :type=> String
  field :opt_in,:type => Boolean
  field :notification, :type=> Boolean
end
