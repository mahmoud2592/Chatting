module UserManagment
  class AdminsController < UsersController

    private
    def user_class
      Admin
    end

    def params_key
      :admin
    end
  end
end