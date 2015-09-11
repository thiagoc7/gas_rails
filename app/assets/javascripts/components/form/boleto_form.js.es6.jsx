var BoletoForm = React.createClass({

  getInitialState() {
    return {
      client_id: null,
      doc_number: null,
      createClientText: null,
      isModalOpen: false,
      clients: [],
      date: moment().format('YYYY-MM-DD'),
      maturity: moment().add(15, 'days').format('YYYY-MM-DD'),
      amount: null,
      discount: null
    }
  },

  componentDidMount() {
    $.ajax({
      type: 'get',
      dataType: "json",
      url: '/clients',
      success: data => this.setState({clients: data.clients}, () => this.forceUpdate()),
      error: error => Materialize.toast(error, 4000)
    });
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
      amount: null,
      discount: null
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
        <div>
          <form onSubmit={this._handleSubmit}>

            <div className="row">

              <div className="field col s6">
                <BoletoFormDrop
                    label="Cliente"
                    clients={this.state.clients}
                    value={this.state.client_id}
                    onChange={this._handleClientChange}
                    onCreate={this._handleClientCreateText}
                    />
              </div>

              <div className="field col s3">
                <label>NF</label>
                <input type="text" ref="nf" value={this.state.doc_number} onChange={this._handleNFChange} />
              </div>

              <div className="field col s3">
                <label>Valor</label>
                <BoletoFormNumber value={this.state.amount} onChange={this._handleValorChange}/>
              </div>

            </div>

            <div className="row">

              <div className="field col s3">
                <label>Desconto</label>
                <BoletoFormNumber value={this.state.discount} onChange={this._handleDescontoChange}/>
              </div>

              <div className="field col s3">
                <label>Vencimento</label>
                <BoletoFormDate value={this.state.maturity} onChange={this._handleVencimentoChange}/>
              </div>

              <div className="field col s3">
                <label>Emissão</label>
                <BoletoFormDate value={this.state.date} onChange={this._handleEmissaoChange}/>
              </div>

              <div className="actions col s3">
                <button type="submit" className="btn waves-effect waves-light" disabled={!this._valid()}>Gravar</button>
              </div>

            </div>

          </form>

          <BoletoFormModal
              initialText={this.state.createClientText}
              isOpen={this.state.isModalOpen}
              onCreate={this._handleClientCreate}
              />
        </div>
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

  _handleClientCreateText(text) {
    this.setState({
      createClientText: text,
      client_id: null
    });
  },

  _handleClientCreate(client) {
    var clients = this.state.clients;
    clients.unshift(client);
    this.setState({
      clients: clients,
      client_id: client.id
    });
    React.findDOMNode(this.refs.nf).focus();
  }
});
