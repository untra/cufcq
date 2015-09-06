class FcqsController < ApplicationController
  before_action :set_fcq, only: [:show, :edit, :update, :destroy]

  # GET /fcqs
  # GET /fcqs.json


  #TODO: Get rid of this in production?
  def index
    paginate :page => 1, :per_page => 1000
    @fcqs = Fcq.all.page(params[:page]).per_page(10)
  end

  # GET /fcqs/1
  # GET /fcqs/1.json
  def show
    # puts params
  end

  # GET /fcqs/new
  def new
    @fcq = Fcq.new
  end

  # GET /fcqs/1/edit
  def edit
  end

  # POST /fcqs
  # POST /fcqs.json
  def create
    @fcq = Fcq.new(fcq_params)

    respond_to do |format|
      if @fcq.save
        format.html { redirect_to @fcq, notice: 'Fcq was successfully created.' }
        format.json { render action: 'show', status: :created, location: @fcq }
      else
        format.html { render action: 'new' }
        format.json { render json: @fcq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fcqs/1
  # PATCH/PUT /fcqs/1.json
  def update
    respond_to do |format|
      if @fcq.update(fcq_params)
        format.html { redirect_to @fcq, notice: 'Fcq was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fcq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fcqs/1
  # DELETE /fcqs/1.json
  def destroy
    @fcq.destroy
    respond_to do |format|
      format.html { redirect_to fcqs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fcq
      @fcq = Fcq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fcq_params
      params.require(:fcq).permit(:yearterm, :subject, :crse, :sec, :instructor_last, :instructor_first, :formsrequested, :formsreturned)
    end
end
