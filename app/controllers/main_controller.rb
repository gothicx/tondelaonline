class MainController < ApplicationController
  def index
#    gem 'rubyweather'
    require 'feed_tools'

    # Weather
#    require 'weather/service'
#    service = Weather::Service.new
#    service.enable_cache
#    service.cache_expiry = 1200
#    service.cache.servers = ['127.0.0.1:11211']
#    service.partner_id = "1102805640"
#    service.license_key = "e3b347cf71fbaa7f"
#    forecast = service.fetch_forecast("POXX0080")
#    $w_temp = forecast.current.temperature.nil? ? "N/D" : forecast.current.temperature
#    $w_img = forecast.current.icon

    # Open/Read RSS Feed
    FeedTools.reset_configurations
    FeedTools.configurations[:tidy_enabled] = false
    FeedTools.configurations[:feed_cache] = "FeedTools::DatabaseFeedCache"
    FeedTools.configurations[:timestamp_estimation_enabled] = false
    @feeds = FeedTools::Feed.open('http://services.sapo.pt/RSS/Feed/local/tondela')
  end

  def contactos
    if request.post?
      @email_nome = params[:email][:nome]
      @email_email = params[:email][:email]
      @email_mensagem = params[:email][:mensagem]

      if @email_nome.empty?
        flash[:error] = "<b>Erro:</b> Introduza o seu Nome..."
        @error = true
      elsif @email_email.empty?
        flash[:error] = "<b>Erro:</b> Introduza o seu E-Mail..."
        @error = true
      elsif not @email_email =~ /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/
        flash[:error] = "<b>Erro:</b> O E-Mail introduzido é inválido..."
        @error = true
      elsif @email_mensagem.empty?
        flash[:error] = "<b>Erro:</b> Introduza a sua Mensagem..."
        @error = true
      elsif @error.blank?
      flash[:error] = nil
      flash[:notice] = "<b>A sua mensagem foi enviada com sucesso!</b>"
      Emailer::deliver_contact_email(params[:email])
      end    
    end
  end
  
end
