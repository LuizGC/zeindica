class PremiosController < ApplicationController
  layout "admin", :except => [:main_page]
	before_filter :login_required, :except => [:main_page, :show]


	def main_page
		@premios = Premio.order('sorteio Desc').page(params[:page]).per((params[:page] == 2 ? 8 : 9))
		
		respond_to do |format|
     	format.html # index.html.erb
			format.js
     	format.json { render :json => @premios }
		end
	end
	
	
	
	# GET /premios
  # GET /premios.json
  def index
    @premios = Premio.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @premios }
    end
  end

  # GET /premios/1
  # GET /premios/1.json
  def show
    @premio = Premio.find(params[:id])
		
		#guarda o id do prêmio usado para mostrar o mesmo prêmio após selecionado
		#também usado para gerar o cupom e deixar o id do prêmio escondido
		session[:premio_id] = params[:id]
		
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => {
				:imagem_info => @premio.imagem_info.url,
				:link_to_imagem_topo =>  @premio.empresa.link_to_imagem_topo,
				:imagem_topo => @premio.empresa.imagem_topo.url,
				:link_to_imagem_meio =>  @premio.empresa.link_to_imagem_meio,
				:imagem_meio => @premio.empresa.imagem_meio.url, 
				:link_to_imagem_inferior =>  @premio.empresa.link_to_imagem_inferior,
				:imagem_inferior => @premio.empresa.imagem_inferior.url, 
				:descricao => @premio.descricao, 
				:sorteio => @premio.sorteio.strftime("%d/%m/%Y"),
				:logado => usuario_signed_in?
			} }
    end
  end

  # GET /premios/new
  # GET /premios/new.json
  def new
    @premio = Premio.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @premio }
    end
  end

  # GET /premios/1/edit
  def edit
    @premio = Premio.find(params[:id])
  end

  # POST /premios
  # POST /premios.json
  def create
    @premio = Premio.new(params[:premio])

    respond_to do |format|
      if @premio.save
        format.html { redirect_to @premio, :notice => 'Premio was successfully created.' }
        format.json { render :json => @premio, :status => :created, :location => @premio }
      else
        format.html { render :action => "new" }
        format.json { render :json => @premio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /premios/1
  # PUT /premios/1.json
  def update
    @premio = Premio.find(params[:id])

    respond_to do |format|
      if @premio.update_attributes(params[:premio])
        format.html { redirect_to @premio, :notice => 'Premio was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @premio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /premios/1
  # DELETE /premios/1.json
  def destroy
    @premio = Premio.find(params[:id])
    @premio.destroy

    respond_to do |format|
      format.html { redirect_to premios_url }
      format.json { head :no_content }
    end
  end
end
