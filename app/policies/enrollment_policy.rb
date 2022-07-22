class EnrollmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index? 
    @user.has_role?(:admin)
  end
  def edit? 
     @record.user == @user
  end

  def update? 
     @record.user == @user
  end

end
