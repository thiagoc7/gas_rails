class Boleto < ActiveRecord::Base
  belongs_to :client
  before_save :set_days_to_maturity

  def to_b
    bank = Bank.where(default_bank: true).first!

    boleto_data = {}
    boleto_data.merge! cedente
    boleto_data.merge! sacado
    boleto_data.merge! bank.to_h
    boleto_data.merge! to_h

    if bank.name == "Santander"
      Brcobranca::Boleto::Santander.new(boleto_data)
    else
      Brcobranca::Boleto::Bradesco.new(boleto_data)
    end
  end

  def to_h
    result = {}

    result[:valor] = amount
    result[:numero_documento] = doc_number
    result[:dias_vencimento] = days_to_maturity
    result[:data_documento] = date.to_date
    result[:instrucao1] = discount_text if discount
    result[:instrucao2] = interest_text

    result
  end

  def discount_text
    "Desconto de R$ #{discount} até o vencimento"
  end

  def interest_text
    "Juros de mora de 2.0% mensal(R$ 0,09 ao dia)"
  end

  def sacado
    {
        sacado: client.name,
        sacado_documento: client.document
    }
  end

  def cedente
    {
        cedente: "Auto Posto Oliveira LTDA",
        documento_cedente: "58.528.845/0001-34"
    }
  end

  private
  def set_days_to_maturity
    days = (maturity.to_date - date.to_date).to_i
    self.days_to_maturity = days
  end
end
