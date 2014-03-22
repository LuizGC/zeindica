class CuponsController < ApplicationController

	def create
		premio = Premio.find(session[:premio_id])

		@cupom_sorteado = Cupom.find_all_by_premio_id_and_premiado(premio.id, true)

		if usuario_signed_in? and @cupom_sorteado.empty?
    	@cupom = current_usuario.cupons.build(:premio => premio)
			if @cupom.save
				session[:cupom_id] = @cupom.id
		 		session[:premio_id] = nil
   	 	end
		end
    
		respond_to do |format|
			format.js
		end
	end

	#Utilizado para realizar o deposito do cupon
	def depositar
			@cupom = Cupom.update(session[:cupom_id], :depositado => true)
			session[:cupom_id] = nil

		 	respond_to do |format|
     		format.js
    	end
	end

	#serve para limpar a session quando o usuário fecha o a janela do prêmio
	def clear_session		 

		if session[:cupom_id].nil? or !usuario_signed_in?
			pode_continuar = true
		else
			pode_continuar  = false
		end

		session[:cupom_id] = nil
		session[:premio_id] = nil


		respond_to do |format|
     	format.json { render :json => pode_continuar}   
		end

	end


	def sortear
		@cupons = Cupom.order("premiado DESC, usuario_id, depositado").find_all_by_premio_id(params[:id])
		respond_to do |format|
			format.html
    end
	end

	def selecionar_cupom
		Cupom.update_all("premiado = false")
		cupom = Cupom.update(params[:id], :premiado => true)

		respond_to do |format|
     	format.json { render :json => cupom.usuario}   
		end


	end


end
