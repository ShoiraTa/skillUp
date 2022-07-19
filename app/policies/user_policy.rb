class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
  if  @user
    def edit? 
      @user.has_role?(:admin)
    end
    def update? 
      @user.has_role?(:admin) 
    end
  end
end
