class UsersController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :set_user, except: [:index, :new, :create, :index_json]
  before_action :admin_user,     only: :destroy

  def index
    @users=User.search(params).paginate(:page => params[:page], :per_page => 10)
  end

  def index_json
    @users=User.search_friends(params, current_user)
    render json: @users.as_json
  end
  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      @user.friendships.create(:friend_id => 2)
      @user.friendships.create(:friend_id => 1)
    end
    if @user.save
      log_in @user
      #@user.create_salary
      #@user.create_performance
      redirect_to @user, flash: {success: "添加成功"}
    else
      flash[:warning] = "账号信息填写有误,请重试"
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      flash={:info => "更新成功"}
    else
      flash={:warning => "更新失败"}
    end
    render 'show'
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path(new: false), flash: {success: "用户删除"}
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :sex, :department_id, :password,
                                 :phonenumber, :status, :avatar)
  end

  # 确认是否登陆用户
  def logged_in_user
    unless logged_in?
      redirect_to sessions_login_url, flash: {danger: '请登陆'}
    end
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      redirect_to root_url, flash: {:danger => '您没有权限浏览他人信息'}
    end
  end

  def set_user
    @user=User.find_by_id(params[:id])
    if @user.nil?
      redirect_to root_path, flash: {:danger => '没有找到此用户'}
    end
  end
  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
