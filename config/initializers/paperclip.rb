Paperclip::Attachment.default_options[:url] = 's3://travel-empire-proofs'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
Paperclip::Attachment.default_options[:s3_host_name] = 's3.ap-south-1.amazonaws.com'
