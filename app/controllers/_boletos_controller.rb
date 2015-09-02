class BoletosController < ApplicationController

	def index
	end

	def santander
		@boleto = Brcobranca::Boleto::Santander.new
		@boleto.cedente = "Auto Posto Oliveira LTDA"
    @boleto.documento_cedente = "58.528.845/0001-34"
    @boleto.sacado = "Thiago Correa"
    @boleto.sacado_documento = "293.745.248-56"
    @boleto.valor = 2.00
    @boleto.agencia = "2171"
    @boleto.conta_corrente = "13000075"
		@boleto.variacao = "9"
		@boleto.aceite = "N"
		# @boleto.carteira = "COB"
		@boleto.convenio = "204218"
		@boleto.numero_documento = "7"
    @boleto.dias_vencimento = 4
    @boleto.data_documento = "2015-09-01".to_date
    @boleto.instrucao1 = "Pagável na rede bancária até a data de vencimento."
    @boleto.instrucao2 = "Juros de mora de 2.0% mensal(R$ 0,09 ao dia)"
    @boleto.instrucao3 = "DESCONTO DE R$ 29,50 APÓS 04/09/2015"

		send_data @boleto.to(:pdf), :filename => "boleto_#{:santander}.#{:pdf}"
	end

	def bradesco
		@boleto = Brcobranca::Boleto::Bradesco.new
		@boleto.cedente = "Auto Posto Oliveira LTDA"
    @boleto.documento_cedente = "58.528.845/0001-34"
    @boleto.sacado = "Thiago Correa"
    @boleto.sacado_documento = "293.745.248-56"
    @boleto.valor = 2.00
    @boleto.agencia = "3900"
    @boleto.conta_corrente = "12"
		@boleto.aceite = "N"
		@boleto.carteira = "09"
		@boleto.numero_documento = "39000000007"
    @boleto.dias_vencimento = 4
    @boleto.data_documento = "2015-09-01".to_date
    @boleto.instrucao1 = "Pagável na rede bancária até a data de vencimento."
    @boleto.instrucao2 = "Juros de mora de 2.0% mensal(R$ 0,09 ao dia)"
    @boleto.instrucao3 = "DESCONTO DE R$ 29,50 APÓS 04/09/2015"

		send_data @boleto.to(:pdf), :filename => "boleto_#{:bradesco}.#{:pdf}"
	end
end
