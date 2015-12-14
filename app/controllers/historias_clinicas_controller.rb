class HistoriasClinicasController < ApplicationController
  # before_action :set_historia_clinica, only: [:show, :edit, :update, :destroy]
  before_action :set_historia_clinica

  def index
    @historias_clinicas = @paciente.historias_clinicas.search(params[:search]).page(params[:page]).per_page(2)
 
   #respond_to do |format|
    #  format.html
     # format.pdf do 
      #  pdf = HistoriasClinicasPdf.new(@historias_clinicas)
      #  send_data pdf.render, filename: 'report.pdf', type: 'application/pdf', :disposition => "inline"
    #  end
   #end

  end

  # GET /pets/1
  # GET /pets/1.json
  def show
    @cie10s = Cie10.all
    @diagnosticos = Diagnostico.all
    @alejo = 0

  end

  # GET /countries/1/edit
  def edit
    #@diagnosticos = Diagnostico.where("historia_clinica_id = @historia_clinica")
 
  end



  


  # GET /pets/new
  def new
    @historia_clinica = HistoriaClinica.new
    @historia_clinica.build_arl  
    @historia_clinica.build_eps 
   end

  # POST /pets
  # POST /pets.json


  def create
    @historia_clinica = HistoriaClinica.new(historia_clinica_params)
    @historia_clinica.paciente_id = @paciente.id

    if @historia_clinica.arl_id.blank?
      @historia_clinica.arl_id = "N/A"
      @historia_clinica.a_nombre_acompañante = "N/A"
      @historia_clinica.a_parentesco = "N/A"
      @historia_clinica.a_telefono = "N/A"
      @historia_clinica.b_fecha_ultima_citologia = "N/A"
      @historia_clinica.b_fecha_ultima_mamografia = "N/A"
    end  

    respond_to do |format|
      if @historia_clinica.save(validate: false)
        format.html { redirect_to paciente_historia_clinica_steps_path(@paciente, @historia_clinica,
         HistoriaClinica.form_steps.second), notice: 'Historia Clinica was successfully created.' }

        format.json { render :show, status: :created, location: @historia_clinica }
      else
        format.html { render :new }
        format.json { render json: @historia_clinica.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /diagnosticos/1
  # PATCH/PUT /diagnosticos/1.json
  



  def update

    respond_to do |format|
      if @historia_clinica.update(historia_clinica_params)
        format.html { redirect_to paciente_historia_clinica_path(@paciente, @historia_clinica), notice: 'clinic_history was successfully updated.' }
        format.json { render :show, status: :ok, location: @historia_clinica }
      else
        format.html { render :edit }
        format.json { render json: @historia_clinica.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /pets/1
  # DELETE /pets/1.json
  def destroy
    @historia_clinica.destroy
    respond_to do |format|
      format.html { redirect_to historias_clinicas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_historia_clinica
      @paciente = Paciente.find(params[:paciente_id])
      @historia_clinica = HistoriaClinica.find(params[:id]) if params[:id]

    end

   
    # Never trust parameters from the scary internet, only allow the white list through.
    # Never trust parameters from the scary internet, only allow the white list through.
    def historia_clinica_params
        params.require(:historia_clinica).permit!

    end




end
