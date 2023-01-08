module UserManagment
  class AdminPolicy < ApplicationPolicy
    def create?
      user && user.admin?
    end
  end
end