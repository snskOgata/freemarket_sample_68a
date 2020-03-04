# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @profile = @user.build_profile
    render :new_profile

    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
      super
    end
    
    
  end

  def create_profile
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(profile_params)
    unless @profile.valid?
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
      render :new_address and return
    end
    @user.build_profile(@profile.attributes)
    @user.build_address(@address.attributes)
    @user.save
    sign_in(:user, @user)
    redirect_to root_path
  end


  protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end
  
  def profile_params
    params[:profile][:birthday] = birthday_join
    params.require(:profile).permit(:lastname, :firstname, :lastname_kana, :firstname_kana, :birthday)
  end

  def birthday_join
    # パラメータ取得
    date = params[:birthday]
    # ブランク時のエラー回避のため、ブランクだったら何もしない
    if date["birthday(1i)"].empty? && date["birthday(2i)"].empty? && date["birthday(3i)"].empty?
      return
    end
    # 年月日別々できたものを結合して新しいDate型変数を作って返す
    Date.new date["birthday(1i)"].to_i,date["birthday(2i)"].to_i,date["birthday(3i)"].to_i
  end

  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city, :block_number, :phone_number, :building)
  end

end
