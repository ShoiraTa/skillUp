module ApplicationHelper
  include Pagy::Frontend
def action_label(key)
  case key
    when 'create'
      "<i class='fa fa-plus'></i>".html_safe
    when 'update'
      "<i class='fa fa-pen'></i>".html_safe
    else 'delete'
      "<i class='fa fa-trash'></i>".html_safe
    end
  end

  def model_label(key)
    case key
      when 'Course'
        "<i class='fa fa-graduation-cap'></i>".html_safe
      when 'Lesson'
        "<i class='fa fa-tasks'></i>".html_safe
      end
    end
end
