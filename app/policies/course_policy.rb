class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
    def edit? 
      @record.user == @user
    end
    def show? 
      @record.published && @record.approved || @user.present? && @user.has_role?(:admin) || @user.present? && @record.user == user || @record.bought_course(@user)
    end
    def update? 
      @record.user == @user
    end
    def new? 
      @user.has_role?(:teacher)
    end
    def create? 
      @user.has_role?(:teacher)
    end
    def destroy? 
      @record.user == @user || @user.has_role?(:admin)
    end
    def approve? 
      @user.has_role?(:admin)
    end


end
