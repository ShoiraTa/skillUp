module CoursesHelper
  def enrollment_button(course)
    if current_user 
      if course.user == current_user
        link_to "View Analitics", course_path(course)
        elsif course.enrollments.where(user: current_user).any?
          link_to course_path(course) do 
            "<i class='fa fa-spinner'></i>".html_safe + " " +
             number_to_percentage(course.current_user_progress(current_user), precision: 0) 
          end
        elsif course.price > 0
          link_to number_to_currency(course.price), new_course_enrollment_path(course), class: 'btn btn-md btn-success'
        else
          link_to "Free", new_course_enrollment_path(course), class: 'btn btn-md btn-success'
      end
      else 
        link_to 'Check price', new_course_enrollment_path(course), class: 'btn btn-md btn-success'
      end
  end

  def review_button(course)
    user_course =  course.enrollments.where(user: current_user)
    if current_user
      if user_course.any? 
        if user_course.pending_review.any?
          link_to edit_enrollment_path(user_course.first) do 
            "Add a review"
          end
        else 
          link_to "View review", enrollment_path(user_course.first)
        end
      end
    end
  end
end
