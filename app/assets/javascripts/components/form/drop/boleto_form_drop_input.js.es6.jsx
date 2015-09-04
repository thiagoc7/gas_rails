var BoletoFormDropInput = React.createClass({

  propTypes: {
    inputValue: React.PropTypes.string.isRequired,
    onChange: React.PropTypes.func.isRequired,

    onFocus: React.PropTypes.func.isRequired,
    onBlur: React.PropTypes.func.isRequired,
    onKeyDown: React.PropTypes.func.isRequired
  },

  // focus after submit
  //componentDidUpdate(prevProps, prevState) {
  //  if (this.props.value !== prevProps.value) {
  //    React.findDOMNode(this.refs.input).focus();
  //  }
  //},

  render() {
    return (
        <input
            type="text"
            value={this.props.inputValue}
            ref="input"
            onChange={this.props.onChange}
            onFocus={this.props.onFocus}
            onBlur={this.props.onBlur}
            onKeyDown={this.props.onKeyDown}
            />
    );
  }


});
