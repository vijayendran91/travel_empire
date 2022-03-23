class WhatsappNumber
  include Mongoid::Document
  belongs_to :trips
  field :phone, :type=> String
  field :opt_in,:type => Boolean
  field :notification, :type=> Boolean
end
