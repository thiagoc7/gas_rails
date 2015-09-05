var ReactCSSTransitionGroup = React.addons.CSSTransitionGroup;

var BoletoFormModal = React.createClass({

  propTypes: {
    initialText: React.PropTypes.string,
    onCreate: React.PropTypes.func.isRequired
  },

  getInitialState() {
    return {
      ref: null,
      name: null,
      document: null
    }
  },

  _modal: null,

  componentWillReceiveProps: function(nextProps) {
    var textIsNumber = !isNaN(nextProps.initialText);
    if (textIsNumber) {
      this.setState({ref: nextProps.initialText})
    } else {
      this.setState({name: nextProps.initialText})
    }
  },

  componentDidMount: function() {
    this._modal = $(this.refs.modal.getDOMNode());
  },

  componentDidUpdate(prevProps, prevState) {
    if (this.props.initialText !== prevProps.initialText) {
      this._modal.openModal();
      React.findDOMNode(this.refs.ref).focus();
    }
  },

  componentWillUnmount: function () {
    this._modal.closeModal();
  },

  render() {
    return (
        <div className="modal" ref="modal">

          <form onSubmit={this._handleSubmit}>

            <div className="modal-content row">

              <div className="field col s2">
                <label>Ref</label>
                <input
                    type="text"
                    ref="ref"
                    value={this.state.ref}
                    onChange={this._handleRefChange}
                    />
              </div>

              <div className="field col s5">
                <label>Nome</label>
                <input
                    type="text"
                    value={this.state.name}
                    onChange={this._handleNameChange}
                    />
              </div>

              <div className="field col s5">
                <label>Documento</label>
                <input
                    type="text"
                    value={this.state.document}
                    onChange={this._handleDocChange}
                    />
              </div>

            </div>

            <div className="modal-footer row">

              <div className="actions col offset-s3 s3">
                <button type="submit" className="btn waves-effect waves-light" disabled={!this._valid()}>Gravar</button>
              </div>

            </div>

          </form>
        </div>
    );
  },

  _handleSubmit(e) {
    e.preventDefault();

    $.ajax({
      type: 'post',
      dataType: "json",
      url: '/clients',
      data: { client: this.state },
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

    this._modal.closeModal();
    Materialize.toast('salvo!', 4000, 'toast-success');
    this.props.onCreate(data);
  },

  _submitError(error) {
    Materialize.toast('falhou! ' + error, 4000, 'toast-fail');
    console.log(error)
  },

  _valid() {
    return this.state.ref &&
        this.state.name &&
        this.state.document
  },

  _handleRefChange(e) {
    this.setState({ref: e.target.value});
  },

  _handleNameChange(e) {
    this.setState({name: e.target.value});
  },

  _handleDocChange(e) {
    this.setState({document: e.target.value});
  }

});
