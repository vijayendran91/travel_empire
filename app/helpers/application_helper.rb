module ApplicationHelper

  def flash_class(level)
    level = level.to_sym      
    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
        when :danger then "alert alert-danger"
    end
  end

end
