json.username @profile.owner.name
json.avatar url_for(@profile.owner.avatar) if @profile.owner.avatar.present?
json.partial! "user_managment/commercial_profiles/commercial_profile", commercial_profile: @profile
