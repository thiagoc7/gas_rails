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
      //data: { boleto: this.state },
      success: data => this.setState({boletos: data.boletos}),
      error: error => Materialize.toast(error, 4000)
    });

    $.ajax({
      type: 'get',
      dataType: "json",
      url: '/clients',
      //data: { boleto: this.state },
      success: data => this.setState({clients: data.clients}),
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
            <BoletoFilter />
          </div>
          <div className="divider"></div>

          <div className="section">
            <BoletoTable boletos={this.state.boletos}/>
          </div>

        </div>
    )
  },

  _handleNewRecord(data) {
    var boletos = this.state.boletos;
    boletos.unshift(data);
    this.setState({boletos: boletos});
  }
});
