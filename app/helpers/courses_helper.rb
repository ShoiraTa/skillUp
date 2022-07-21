module CoursesHelper
  def enrollment_button(course)
    if current_user 
      if course.user == current_user
        link_to "View Analitics", course_path(course)
        elsif course.enrollments.where(user: current_user).any?
          link_to "View Course", course_path(course)
        elsif course.price > 0
          link_to number_to_currency(course.price), new_course_enrollment_path(course), class: 'btn btn-md btn-success'
        else
          link_to "Free", new_course_enrollment_path(course), class: 'btn btn-md btn-success'
      end
      else 
        link_to 'Check price', course_path(course), class: 'btn btn-md btn-success'
      end
  end
end
