class ProjectUsersController < ApplicationController
  before_action :set_project

  # POST /projects/:project_id/users
  def create
    @user = User.find(params[:user_id])
    @project.users << @user unless @project.users.include?(@user)

    render json: { message: "User added to project", project: @project, users: @project.users }, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # DELETE /projects/:project_id/users/:id
  def destroy
    @user = User.find(params[:id])
    @project.users.delete(@user)

    render json: { message: "User removed from project" }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Project not found" }, status: :not_found
  end
end

