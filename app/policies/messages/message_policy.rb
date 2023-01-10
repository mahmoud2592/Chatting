module Messages
  class MessagePolicy < ApplicationPolicy

    class Scope < Scope
      def resolve
        scope
      end
    end

    def show?
     true
    end

    def create?
      true
    end

    def update?
      true
    end

    def destroy?
      true
    end
  end
end
