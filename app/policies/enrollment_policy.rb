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
    @user.present? && @record.user == @user
  end

  def update? 
     @record.user == @user
  end
  def destroy? 
     @record.user == @user
  end

end
