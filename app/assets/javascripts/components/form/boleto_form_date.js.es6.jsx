var BoletoFormDate = React.createClass({

  _mask: null,

  getInitialState() {
    var value = undefined;
    if (this.props.value) { value = moment(this.props.value).format('DD/MM/YYYY')}
    return {
      displayValue: value
    };
  },

  componentDidMount() {
    this._mask = $(this.refs.input.getDOMNode()).mask('00/00/0000');
  },

  componentWillUnmount: function () {
    this._mask.unmask();
  },

  _handleChange(e) {
    this.setState({displayValue: e.target.value});
    var newDate = moment(e.target.value, 'DD/MM/YYYY').format('YYYY-MM-DD');
    this.props.handleChange(newDate)
  },

  render() {
    return <input
        type="text"
        ref="input"
        value={this.state.displayValue}
        onChange={this._handleChange}
        />
  }
});
