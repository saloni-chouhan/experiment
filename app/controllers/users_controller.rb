class UsersController < ApplicationController

  before_action :set_user, only: %i[ show edit update destroy ]
  

  # GET /users or /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.csv do
        send_data User.to_csv(@users), filename: Date.today.to_s, content_type: "text/csv"
      end
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    headers = ["Username", "Login email", "Identifier", "First name", "Last name"]

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    file = params[:file]
    return redirect_to users_path, notice: "Only csv please" unless file.content_type == "text/csv"
   
    CsvImportUsersService.new.call(file)

    redirect_to users_path, notice: "Users Imported!!!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :identifier, :first_name, :last_name)
    end
end
