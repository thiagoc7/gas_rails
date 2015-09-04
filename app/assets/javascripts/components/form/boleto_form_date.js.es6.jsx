var BoletoFormDate = React.createClass({

  _mask: null,

  getInitialState() {
    var value = undefined;
    if (this.props.value) { value = moment(this.props.value).format('DD/MM/YYYY')}
    return {
      value: value
    };
  },

  componentDidMount() {
    this._mask = $(this.refs.input.getDOMNode()).mask('00/00/0000');
  },

  componentWillUnmount: function () {
    this._mask.unmask();
  },

  _handleChange(e) {
    this.setState({value: e.target.value});
  },

  _setDate() {
    var newDate = moment(this.state.value, 'DD/MM/YYYY').format('YYYY-MM-DD');
    this.props.handleChange(newDate)

  },

  render() {
    return <input
        type="text"
        ref="input"
        value={this.state.value}
        onChange={this._handleChange}
        onBlur={this._setDate}
        />
  }
});
