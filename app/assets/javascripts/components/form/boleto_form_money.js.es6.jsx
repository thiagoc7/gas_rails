var BoletoFormMoney = React.createClass({

  _mask: null,

  componentDidMount: function() {
    this._mask = $(this.refs.input.getDOMNode());
    this._mask.maskMoney({
      thousands: '.',
      decimal: ','
    });

    this._mask.on('change', () => {
      this.props.onChange(this._mask.maskMoney('unmasked')[0]);
    });
  },

  componentWillReceiveProps(nextProps) {
    if (this.props.value !== nextProps.value) {
      this._mask.val(nextProps.value).maskMoney('mask');
    }
  },

  componentWillUnmount: function () {
    this._mask.maskMoney('destroy');
  },

  render() {
    return (
        <input type="text" ref="input" defaultValue={this.props.value} />
    );
  }

});
