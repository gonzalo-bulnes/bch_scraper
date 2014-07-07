require 'mechanize'

class BancoScrapper

  def initialize(rut, password)
    @agent = Mechanize.new
    @rut = rut
    @password = password
  end

  def after_login
    page = @agent.post('https://www.bancochile.cl/bchile-perfilamiento/Process?AID=VALIDA_CLAVE-0000', {
      "CustLoginID" => @rut,
      "SignonPswd" => @password,
      "relogin" => "0",
      "pagina" => "login"
    })
    page = @agent.post('https://www.bancochile.cl/bchile-perfilamiento/Process?AID=LOGIN-0004')
    login_form = page.forms[0]
    login_form.rutOri = @rut.split("-")[0]
    login_form.CustLoginID = @rut
    login_form.SignonPswd = @password
    main_page = @agent.submit(login_form)
    yield(main_page)
  end

  def balance
    after_login do |main_page|
      products = bch_data_as_json(@agent.get('https://www.bancochile.cl/bchile-perfilamiento/Ajax?AID=AJAX_OBTENER_SALDOS1&indice=0').body)
      format_money(products[1]["montoDisponible"])
    end
  end
  
  private
    def bch_data_as_json(data)
      JSON.parse data.gsub(/\'/, "\"")
    end

    # changes this number: 1000000 to this string; "$1.000.000"
    def format_money(money)
      money_with_dots = money.reverse.scan(/.{3}|.+/).join(".").reverse
      "$#{money_with_dots}" 
    end
end
