class Retorno
  attr_accessor :file, :boletos, :errors, :title

  def initialize(file)
    @file = file.path
    @title = "pagamentos"
    @boletos = []
    @errors = []
    choose_bank
  end

  def choose_bank
    bank = Bank.default.name
    if bank == "Santander"
      handle_santander_file
    elsif bank == "Bradesco"
      handle_bradesco_file
    end
  end

  def handle_santander_file
  end

  def handle_bradesco_file
    Brcobranca::Retorno::Cnab400::Bradesco.load_lines(@file).each do |line|
      doc_number = line.nosso_numero[0..(line.nosso_numero.size - 2)].to_i
      next if doc_number == 0
      boleto = Boleto.where(doc_number: doc_number).last
      boleto ? @boletos << boleto_obj(line, boleto) : @errors << error_obj(line, doc_number)
    end
  end

  def boleto_obj(line, boleto)
    {
        client: boleto.client.name,
        doc_number: boleto.doc_number,
        maturity: boleto.maturity,
        paid_on: parse_date(line.data_credito),
        amount: boleto.amount,
        discount: boleto.discount,
        amount_paid: line.valor_titulo.to_f / 100
    }
  end


  def error_obj(line, doc_number)
    {
      doc_number: doc_number,
      paid_on: parse_date(line.data_credito),
      amount_paid: line.valor_titulo.to_f / 100
    }
  end

  def parse_date(date)
    day = date[0..1].to_i
    month = date[2..3].to_i
    year = date[4..5].to_i + 2000
    Date.new(year, month, day)
  end

end