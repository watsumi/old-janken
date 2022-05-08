class SpiesController < ApplicationController
  before_action :set_spy, only: %i[ show edit update destroy ]

  # GET /spies
  def index
    @spies = Spy.all
  end

  # GET /spies/1
  def show
    if request.headers["turbo-frame"]
      render partial: 'spy', locals: { spy: @spy }
    else
      render 'show'
    end
  end

  # GET /spies/new
  def new
    @spy = Spy.new
  end

  # GET /spies/1/edit
  def edit
  end

  # POST /spies
  def create
    @spy = Spy.new(spy_params)

    respond_to do |format|
      if @spy.save
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_spy", partial: "spy_link") }
        format.html { redirect_to @spy, notice: "Spy was successfully created."}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spies/1
  def update
    if @spy.update(spy_params)
      redirect_to @spy, notice: "Spy was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /spies/1
  def destroy
    @spy.destroy
    redirect_to spies_url, notice: "Spy was successfully destroyed."
  end

  def clearance
    secret_clearance ? session.delete(:clearance) : session[:clearance] = true
    redirect_to spies_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spy
      @spy = Spy.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def spy_params
      params.require(:spy).permit(:name, :mission)
    end
end
