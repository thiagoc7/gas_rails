var BoletoForm = React.createClass({

  getInitialState() {
    return {
      client_id: null,
      doc_number: null,
      date: moment().format('YYYY-MM-DD'),
      maturity: moment().add(15, 'days').format('YYYY-MM-DD'),
      amount: 0.00,
      discount: 0.00
    }
  },

  _handleSubmit(e) {
    e.preventDefault();

    $.ajax({
      type: 'post',
      dataType: "json",
      url: '/boletos',
      data: { boleto: this.state },
      success: data => this._submitSuccess(data),
      error: error => this._submitError(error)
    });
  },

  _submitSuccess(data) {
    this.setState({
      client_id: null,
      doc_number: null,
      amount: undefined,
      discount: undefined
    });

    Materialize.toast('salvo!', 4000, 'toast-success');

    this.props.handleNewRecord(data);
  },

  _submitError(error) {
    Materialize.toast('falhou! ' + error, 4000, 'toast-fail');
    console.log(error)
  },



  render: function() {
    return (
        <form onSubmit={this._handleSubmit}>

          <div className="row">

            <div className="field col s3">
              <BoletoFormDrop
                  label="Clientes"
                  clients={[{id: 1, name: 'abc'}, {id: 2, name: 'bcd'}, {id: 3, name: 'cde'}]}
                  value={this.state.client_id}
                  onChange={this._handleClientChange}
                  onCreate={this._handleClientCreate}
                  />
            </div>

            <div className="field col s3">
              <label>NF</label>
              <input type="text" value={this.state.doc_number} onChange={this._handleNFChange} />
            </div>

            <div className="field col s3">
              <label>Valor</label>
              <BoletoFormMoney value={this.state.amount} onChange={this._handleValorChange}/>
            </div>

            <div className="field col s3">
              <label>Desconto</label>
              <BoletoFormMoney value={this.state.discount} onChange={this._handleDescontoChange}/>
            </div>

          </div>

          <div className="row">

            <div className="field col s3">
              <label>Vencimento</label>
              <BoletoFormDate value={this.state.maturity} handleChange={this._handleVencimentoChange}/>
            </div>

            <div className="field col s3">
              <label>Emissão</label>
              <BoletoFormDate value={this.state.date} handleChange={this._handleEmissaoChange}/>
            </div>

            <div className="actions col offset-s3 s3">
              <button type="submit" className="btn waves-effect waves-light" disabled={!this._valid()}>Gravar</button>
            </div>

          </div>

        </form>
    )
  },

  _valid() {
    return this.state.client_id &&
        this.state.doc_number &&
        this.state.date &&
        this.state.maturity &&
        this.state.amount &&
        this.state.discount
  },

  _handleClientChange(newClient) {
    this.setState({client_id: newClient});
  },

  _handleNFChange(e) {
    this.setState({doc_number: e.target.value});
  },

  _handleEmissaoChange(newDate) {
    this.setState({date: newDate});
  },

  _handleVencimentoChange(newDate) {
    this.setState({maturity: newDate});
  },

  _handleValorChange(newValue) {
    this.setState({amount: newValue});
  },

  _handleDescontoChange(newValue) {
    this.setState({discount: newValue});
  },

  _handleClientCreate(text) {
    alert(text);
    this.setState({client_id: 1});
  }
});
