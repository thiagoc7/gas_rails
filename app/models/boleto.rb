class Boleto < ActiveRecord::Base
  belongs_to :client
  before_save :set_days_to_maturity

  validates_presence_of :client, :doc_number, :amount, :date, :maturity

  def to_b
    bank = Bank.where(default_bank: true).first!

    boleto_data = {}
    boleto_data.merge! client.to_h
    boleto_data.merge! bank.to_h
    boleto_data.merge! to_h
    boleto_data.merge! instructions(bank)

    unless printed?
      self.printed = true
      self.save!
    end

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

    result
  end

  def instructions(bank)
    result = {}
    count = 1

    if discount && discount > 0
      discount_display = discount.to_s.gsub('.', ',').gsub(/\B(?=(\d{3})+(?!\d))/, '.')
      result["instrucao#{count}".to_sym] = "Desconto de R$ #{discount_display} até o vencimento"
      count += 1
    end

    if bank.instrucao_juros.present?
      result["instrucao#{count}".to_sym] = bank.instrucao_juros
    end

    result
  end

  private
  def set_days_to_maturity
    days = (maturity.to_date - date.to_date).to_i
    self.days_to_maturity = days
  end
end
