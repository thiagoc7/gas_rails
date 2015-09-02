var BoletoTable = React.createClass({

  render: function() {
    return (
        <table className="bordered">

          <thead>
            <tr>
              <th>Data</th>
              <th>Vencimento</th>
              <th>NF</th>
              <th>Cliente</th>
              <th>Valor</th>
              <th>Desconto</th>
              <th></th>
            </tr>
          </thead>

          <tbody>
            {this.props.boletos.map(boleto => <BoletoTableLine boleto={boleto} key={boleto.id}/>)}
          </tbody>

        </table>
    );
  }
});
