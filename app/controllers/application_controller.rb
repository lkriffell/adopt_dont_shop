class ApplicationController < ActionController::Base
  # before_action :detect_device_type
  #
  # private
  #
  #   def detect_device_type
  #     case request.user_agent
  #     when /iPhone/i
  #       request.variant = :phone
  #     when /Android/i && /mobile/i
  #       request.variant = :phone
  #     when /Windows Phone/i
  #       request.variant = :phone
  #     end
  #   end
end
