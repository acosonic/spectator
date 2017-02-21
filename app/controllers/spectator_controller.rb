class SpectatorController < ApplicationController

  before_filter :require_login, :check_page_access

  def user_list
    @user_names = User.active.like(params[:term]).order(:firstname, :lastname).limit(10).map{|u| {label: u.name, value: u.id}}

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
      
      if params[:user_change_id] && !params[:user_change_id].blank?
        user_spec = User.find(params[:user_change_id])
      else
        term = params[:user_change]
        user_spec = User.active.like(term).order(:firstname, :lastname).first
        raise ActiveRecord::RecordNotFound unless user_spec
      end

      spec_id = session[:spectator_id]

      if user_spec.id == spec_id
        session[:spectator_id] = nil
      else
        session[:spectator_id] = User.current.id
      end

      session[:user_id] = user_spec.id
      session[:tk] = user_spec.generate_session_token

    rescue ActiveRecord::RecordNotFound
      flash[:error] = "User not found"
    end
    redirect_to :action=> :index
  end

  def check_page_access
    render_403 unless User.current.admin? || session[:spectator_id]
  end

end
