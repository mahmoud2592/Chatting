module UserManagment
  class ProfilesController < ApplicationController
    before_action :find_profile, only: [:show, :update]

    def show
      authorize @profile, policy_class: UserManagment::ProfilePolicy

      render 'show', status: 200
    end

    def update
      authorize @profile, policy_class: UserManagment::ProfilePolicy

      if @profile.update(profile_params)
        current_user.update(username) if username
        render :show, status: 200
      else
        render json: {:errors => @profile.errors}, status: :unprocessable_entity
      end
    end

    private

    def profile_params
      params.require(:profile)
            .permit(:bio, :profile_name, :email, :tax_number, :commercial_register)
            .merge(creator_id: current_user.id, owner_id: current_user.id)
    end

    def username
      params.require(:profile).permit(:name, :avatar)
    end

    def find_profile
      @profile = CommercialProfile.find_by(owner_id: current_user.id)
    end
  end
end
