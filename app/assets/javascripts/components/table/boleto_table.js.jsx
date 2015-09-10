var BoletoTable = React.createClass({

  propTypes: {
    boletos: React.PropTypes.array.isRequired,
    onDelete: React.PropTypes.func.isRequired
  },

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

          {this.props.boletos.map(boleto =>
                  <ReactCSSTransitionGroup transitionName="boletoTable" component="tbody">
                    <BoletoTableLine boleto={boleto} key={boleto.id} onDelete={this.props.onDelete}/>
                  </ReactCSSTransitionGroup>
          )}

        </table>
    );
  }
});
