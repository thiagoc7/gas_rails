oliveira = Station.create(name: 'Oliveira', strong_days: '1, 16', weak_days: '15, last')
outeiro = Station.create(name: 'Outeiro')

Tank.create(station: oliveira, gasoline: 'S500', capacity: 30000, min_volume: 20000, max_volume: 55000, number: '1, 3, 6')
Tank.create(station: oliveira, gasoline: 'S10', capacity: 15000, min_volume: 6500, max_volume: 17000, number: 4)
Tank.create(station: oliveira, gasoline: 'GC', capacity: 15000, min_volume: 4500, max_volume: 16000, number: 5)
Tank.create(station: oliveira, gasoline: 'ET', capacity: 10000, min_volume: 2500, max_volume: 10500, number: 2)

Tank.create(station: outeiro, gasoline: 'GC', capacity: 30000, min_volume: 6000, max_volume: 31000, number: '4, 5')
Tank.create(station: outeiro, gasoline: 'GA', capacity: 15000, min_volume: 3000, max_volume: 15000, number: 6)
Tank.create(station: outeiro, gasoline: 'ET', capacity: 15000, min_volume: 3000, max_volume: 15000, number: 3)
Tank.create(station: outeiro, gasoline: 'S10', capacity: 15000, min_volume: 3000, max_volume: 15000, number: 2)
Tank.create(station: outeiro, gasoline: 'S500', capacity: 15000, min_volume: 3000, max_volume: 15000, number: 1)

# Measure.import('db/measures/gas_oliv.csv', 1, 'GC')
# Measure.import('db/measures/et_oliv.csv', 1, 'ET')
# Measure.import('db/measures/s10_oliv.csv', 1, 'S10')
# Measure.import('db/measures/s500_oliv.csv', 1, 'S500')
#
# Measure.import('db/measures/ET_outeiro.csv', 2, 'ET')
# Measure.import('db/measures/GA_outeiro.csv', 2, 'GA')
# Measure.import('db/measures/GC_outeiro.csv', 2, 'GC')
# Measure.import('db/measures/S10_outeiro.csv', 2, 'S10')
# Measure.import('db/measures/S500_outeiro.csv', 2, 'S500')
#
# Plan.update_all(finished: true)

User.create(email: 'thiagobocorrea@gmail.com', password: 'thiago00')
User.create(email: 'dantasbravo@gmail.com', password: 'dantas00')

Client.create(name:"Thiago Correa", document: "293.745.248-56", ref: 1040)

Bank.create(
        name: "Bradesco",
        cedente: "Auto Posto Oliveira LTDA",
        cedente_doc: "58.528.845/0001-34",
        cedente_address: "Rua São Francisco, 12. Osasco-SP",
        agencia: "3900",
        conta_corrente: "12",
        carteira: "09",
        default_bank: true,
        instrucao_juros: "Após o Vencimento multa de 5,0% e juros de 4%a.m."
)

Bank.create(
    name: "Santander",
    cedente: "Auto Posto Oliveira LTDA",
    cedente_doc: "58.528.845/0001-34",
    agencia: "2171",
    conta_corrente: "13000075",
    variacao: "9",
    convenio: "204218",
    instrucao_juros: "Após o Vencimento multa de 5,0% e juros de 4%a.m."
)

Boleto.create(
          client: Client.first,
          doc_number: "39000000007",
          date: Date.today,
          maturity: Date.today + 5.days,
          amount: 10.00,
          discount: 1.05
)

