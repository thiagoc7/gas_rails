var BoletoFormPopover = React.createClass({

  propTypes: {
    clients: React.PropTypes.array.isRequired,
    currentIndex: React.PropTypes.number.isRequired
  },

  getInitialState() {
    return {ulMarginTop: 0}
  },

  componentWillReceiveProps(nextProps) {
    if (nextProps.currentIndex < 3) {
      this.setState({ulMarginTop: 0})
    } else {
      var base = 15;
      var div = 37;
      var elements = nextProps.currentIndex - 3;
      this.setState({ulMarginTop: (base + (div * elements)) * -1})
    }
  },

  render() {
    var ulStyle = {
      marginTop: this.state.ulMarginTop
    };

    return (
        <div className='drop-popover'>
          <ul style={ulStyle}>
            {this.props.clients.map((obj, idx) => this.renderItem(obj, idx))}
          </ul>
        </div>
    );
  },

  renderItem(obj, index) {
    if (index == this.props.currentIndex) {
      return <li className="active" key={obj.id}>{obj.name}</li>
    } else {
      return <li key={obj.id}>{obj.name}</li>
    }
  },

  renderCreate() {
    if (this.props.inputValue.length == 0) {
      return undefined;
    } else {
      return <li>+ {this.props.inputValue}</li>
    }
  }


});
