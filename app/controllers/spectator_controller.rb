class SpectatorController < ApplicationController

  before_filter :require_login, :check_page_access

  def user_list
    @user_names = User.active.like(params[:term]).limit(10).map{|u| {label: u.name, value: u.id}}.sort_by{|a| a[:label]}

    @user_names = [{label: "No result", value: "None" }] if @user_names.blank?

    respond_to do |format|
      format.js {
        render :json => @user_names.to_json
      }
    end

  end

  def index
  end

  def change_user
    begin
      user_spec = User.find(params[:user_change_id])
      session[:user_id] = params[:user_change_id]
      session[:tk] = user_spec.generate_session_token
      session[:spectator_id] ||= User.current.id
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "User not found"
    end
    redirect_to :action=> :index
  end

  def check_page_access
    render_403 unless User.current.admin? || session[:spectator_id]
  end

end
