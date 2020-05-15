class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve 
      scope.where(user: user)
    end
  end


  def show 
    true
  end

  def update?
    (record.status == "pending") && (user_is_owner? || record.room.user == user)
  end

  def create?
    true
  end

  def destroy?
    user_is_owner?
  end

  private

  def user_is_owner?
    record.user == user
  end
end
