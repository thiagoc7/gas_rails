class Bank < ActiveRecord::Base
  validates_presence_of :name, :agencia, :conta_corrente

  after_save :ensure_only_one_default

  def to_h
    result = {}

    result[:agencia] = agencia
    result[:conta_corrente] = conta_corrente
    result[:aceite] = aceite

    result[:variacao] = variacao unless variacao.empty?
    result[:carteira] = carteira unless carteira.empty?
    result[:convenio] = convenio.to_i unless convenio.empty?

    result
  end

  private
  def ensure_only_one_default
    if self.default_bank?
      Bank.where('id != ?', self.id).update_all("default_bank = 'false'")
    end
  end
end
