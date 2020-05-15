class DashboardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    
    end
  end


  def show?
    # user_is_owner?
    true
  end


  private

  def user_is_owner?
    record.user == user
  end
  
end
