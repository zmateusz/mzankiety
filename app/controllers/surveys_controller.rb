class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.order(created_at: :desc) ## where(:shared => true)
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)
    if current_user == nil
      @survey.author = "anonim"
    else
      @survey.author = current_user.username
    end
    respond_to do |format|
      if @survey.save
        format.html { redirect_to detail_survey_path(@survey), notice: 'Ankieta zostala pomyslnie utworzona.' }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Ankieta zostala pomyslnie zaktualizowana.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to inside_url, notice: 'Ankieta zostala pomyslnie skasowana.' }
      format.json { head :no_content }
    end
  end

  def toggles
    @survey = Survey.find(params[:id])
    if @survey.shared == true 
      @survey.shared = false
      @survey.save
    else
      @survey.shared = true
      @survey.save
    end
    redirect_to detail_survey_path(@survey)
  end

  def detail
    @survey = Survey.find(params[:id])
  end

  def enddate
    detail
    end_date = params[:survey]
    if @survey.ends_at.nil?
      new_date = DateTime.new(end_date["created_at(1i)"].to_i,
                          end_date["created_at(2i)"].to_i,
                          end_date["created_at(3i)"].to_i,
                          end_date["created_at(4i)"].to_i-1, #poprawka do strefy czasowej, inny sposob?
                          end_date["created_at(5i)"].to_i)
    else
      new_date = DateTime.new(end_date["ends_at(1i)"].to_i,
                          end_date["ends_at(2i)"].to_i,
                          end_date["ends_at(3i)"].to_i,
                          end_date["ends_at(4i)"].to_i-1,
                          end_date["ends_at(5i)"].to_i)
    end
    @survey.update_attribute(:ends_at, new_date)
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:name, :descr, :author)
    end
end
