module UserManagment
  class ProfilePolicy < ApplicationPolicy

    def show?
      true
    end

    def update?
      true
    end
    
  end
end