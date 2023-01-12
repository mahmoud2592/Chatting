module Messages
  class MessagePolicy < ApplicationPolicy

    class Scope < Scope
      def resolve
        scope
      end
    end

    def show?
     current_user
    end

    def create?
      current_user
    end

    def update?
      current_user.id == record.user_id
    end

    def destroy?
      current_user.id == record.user_id
    end
  end
end
