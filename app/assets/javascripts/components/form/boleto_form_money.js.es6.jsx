var BoletoFormMoney = React.createClass({

  _mask: null,

  getInitialState() {
    var value = undefined;
    if (this.props.value) { value = parseFloat(this.props.value).toFixed(2)}
    return {
      value: value
    };
  },

  componentDidMount() {
    this._mask = $(this.refs.input.getDOMNode()).mask('000.000,00', {reverse: true});
  },

  componentWillUnmount: function () {
    this._mask.unmask();
  },

  _handleChange(e) {
    this.setState({value: e.target.value});
  },

  _setValue() {
    var newValue = parseFloat(this._mask.cleanVal()) / 100;
    this.props.handleChange(newValue)
  },

  render() {
    return <input
        type="text"
        ref="input"
        value={this.state.value}
        onChange={this._handleChange}
        onBlur={this._setValue}
        />
  }
});
