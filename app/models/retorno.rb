class Retorno
  attr_accessor :line

  def initialize line
    @line = line
  end

  def identificacao_registro
    @line[0].to_i
  end

  def tipo_inscricao
    @line[1..2]
  end

  def inscricao
    @line[3..16]
  end

  def titulo
    @line[72..81]
  end

  def data_ocorrencia
    @line[110..115]
  end

  def numero_documento
    @line[116..125]
  end

  def data_credito
    @line[295..300]
  end

  def valor_pago
    @line[254..265]
  end
end