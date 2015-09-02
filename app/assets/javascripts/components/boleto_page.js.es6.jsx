var BoletoPage = React.createClass({

  getInitialState() {
    return {
      boletos: this.props.boletos,
      clients: this.props.clients
    }
  },


  render: function() {
    return (
        <div>
          <h3>Boletos</h3>

          <div className="section">
            <BoletoForm clients={this.state.clients}/>
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
  }
});
