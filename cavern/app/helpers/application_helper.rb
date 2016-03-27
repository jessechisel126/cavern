module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", danger: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  # Taken from https://gist.github.com/suryart/7418454
  # Handles flash message displaying through bootstrap
  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for msg_type} fade in", id: "flash") do 
              concat message
            end)
    end
    nil
  end
end
