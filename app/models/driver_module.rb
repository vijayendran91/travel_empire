class DriverModule
  include Mongoid::Document
  include Mongoid::Paperclip
  belongs_to :trip

  has_mongoid_attached_file :dr_photoproof1
  has_mongoid_attached_file :dr_odometer_start
  has_mongoid_attached_file :dr_odometer_close
  validates_attachment :dr_photoproof1, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "application/pdf"] }
  validates_attachment :dr_odometer_start, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "application/pdf"] }
  validates_attachment :dr_odometer_close, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "application/pdf"] }

  # I Form
  field :auth_person, type: String
  field :auth_mob, type: String
  field :dr_name, type: String
  field :dr_mob, type: String
  field :lic_no, type: String
  field :car_model, type: String
  field :dr_dl_no, type: String
  field :st_km, type: Float
  field :tr_start_time, type: DateTime
  field :advance, type: Integer
  field :emp_name, type: String
  field :emp_id, type: String
  field :emp_phone, type: String


  # II Form
  field :cl_km, type: Float
  field :total_toll, type: Integer
  field :permit, type: Integer
  field :cl_time, type: DateTime
  field :in_city, type: Boolean





end
