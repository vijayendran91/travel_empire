module WhatsappHelper

  def time_difference_hrs(timestamp)
    now = Time.now
    difference = (now - timestamp.utc)
    return difference
  end

  def get_wa_media_api_call(file_url, sha)
    response = HTTParty.get(file_url,
          :headers => {'Content-Type' => 'application/json',
                        'Authentication' => 'Bearer na2JvXULNrlLYfw1BzsMyw==',
                        'SHA256' => sha
                      }
        )
    response
  end

  def get_action_dispatch_upload_file(data, content_type, filename)
    tempfile = Tempfile.new(filename)
    tempfile.binmode
    tempfile.write(data)
    tempfile.rewind
    content_type = content_type
    return ActionDispatch::Http::UploadedFile.new(tempfile: tempfile,type: content_type,filename: filename)
  end

  def encode_media_base64(media)
    file = media.tempfile.open.read.force_encoding(Encoding::UTF_8)
    return Base64.strict_encode64(file)
  end

end
