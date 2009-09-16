module CkeditorHelper
  def new_attachment_path_with_session_information(kind)
    session_key = ActionController::Base.session_options[:key]
    
    options = {}
    controller = case kind
      when :image then Ckeditor::PLUGIN_FILE_MANAGER_IMAGE_UPLOAD_URI
      when :file  then Ckeditor::PLUGIN_FILE_MANAGER_UPLOAD_URI
      else '/ckeditor/create'
    end
    
    if controller.include?('?')
      arr = controller.split('?')
      options = Rack::Utils.parse_query(arr.last)
      controller = arr.first
    end
    
    options[:controller] = controller
    options[:protocol] = "http://"
    options[session_key] = cookies[session_key]
    options[request_forgery_protection_token] = form_authenticity_token unless request_forgery_protection_token.nil?
    
    url_for(options)
  end
end