var BoletoForm = React.createClass({

  getInitialState() {
    return {
      emissao: moment().format('YYYY-MM-DD'),
      vencimento: moment().add(15, 'days').format('YYYY-MM-DD'),
      valor: 0.00,
      desconto: 0.00
    }
  },

  render: function() {
    return (
        <form>

          <div className="row">

            <div className="field col s3">
              <label>Cliente</label>
              <input type="text" />
            </div>

            <div className="field col s3">
              <label>NF</label>
              <input type="text" />
            </div>

            <div className="field col s3">
              <label>Valor</label>
              <BoletoFormMoney value={this.state.valor} handleChange={this._handleValorChange}/>
            </div>

            <div className="field col s3">
              <label>Desconto</label>
              <BoletoFormMoney value={this.state.desconto} handleChange={this._handleDescontoChange}/>
            </div>

          </div>

          <div className="row">

            <div className="field col s3">
              <label>Vencimento</label>
              <BoletoFormDate value={this.state.vencimento} handleChange={this._handleVencimentoChange}/>
            </div>

            <div className="field col s3">
              <label>Emissão</label>
              <BoletoFormDate value={this.state.emissao} handleChange={this._handleEmissaoChange}/>
            </div>

            <div className="actions col offset-s3 s3">
              <button type="submit" className="btn waves-effect waves-light">Gravar</button>
            </div>

          </div>

        </form>
    )
  },

  _handleEmissaoChange(newDate) {
    this.setState({emissao: newDate});
  },

  _handleVencimentoChange(newDate) {
    this.setState({vencimento: newDate});
  },

  _handleValorChange(newValue) {
    this.setState({valor: newValue});
  },

  _handleDescontoChange(newValue) {
    this.setState({desconto: newValue});
  }
});
