class WhatsappOpt
  include Mongoid::Document

  field :phone, :type=> String
  field :opt_in,:type => Boolean
end
