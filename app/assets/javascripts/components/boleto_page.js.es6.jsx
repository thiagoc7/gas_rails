var BoletoPage = React.createClass({

  getInitialState() {
    return {
      boletos: [],
      clients: []
    }
  },

  componentDidMount() {
    $.ajax({
      type: 'get',
      dataType: "json",
      url: '/boletos',
      success: data => this.setState({boletos: data.boletos}),
      error: error => Materialize.toast(error, 4000)
    });
  },

  render: function() {
    return (
        <div>
          <h3>Boletos</h3>

          <div className="section">
            <BoletoForm clients={this.state.clients} handleNewRecord={this._handleNewRecord}/>
          </div>
          <div className="divider"></div>

          <div className="section">
            <BoletoFilter clients={this.state.clients} onFilter={this._handleFilter}/>
          </div>
          <div className="divider"></div>

          <div className="section">
            <BoletoTable boletos={this.state.boletos} onDelete={this._handleDelete}/>
          </div>

        </div>
    )
  },

  _handleNewRecord(data) {
    var boletos = this.state.boletos;
    boletos.unshift(data);
    this.setState({boletos: boletos});
  },

  _handleDelete(boleto) {
    var boletos = this.state.boletos.slice();
    var index = boletos.indexOf(boleto);
    boletos.splice(index, 1);
    this.replaceState({boletos: boletos}, () => Materialize.toast('boleto ' + boleto.doc_number + ' apagado', 4000, 'toast-fail'));
  },

  _handleFilter(result) {
    this.setState({boletos: result})
  }

});
