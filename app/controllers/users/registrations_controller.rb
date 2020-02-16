# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @profile = @user.build_profile
    render :new_profile
  end

  def create_profile
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(profile_params)
    unless @profile.valid?
      flash.now[:alert] = @profile.errors.full_messages
      render :new_profile and return
    end
    @user.build_profile(@profile.attributes)
    session["profile"] = @profile.attributes
    @address = @user.build_address
    render :new_address

  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(session["profile"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_profile(@profile.attributes)
    @user.build_address(@address.attributes)
    @user.save
    sign_in(:user, @user)

  end

  protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end
  
  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city, :block_number, :phone_number, :building)
  end

  def profile_params
    params.require(:profile).permit(:lastname, :firstname, :lastname_kana, :firstname_kana, :birthday)
  end
end
