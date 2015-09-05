var BoletoFormPopover = React.createClass({

  propTypes: {
    clients: React.PropTypes.array.isRequired,
    currentIndex: React.PropTypes.number.isRequired
  },


  render() {
    return (
        <div className='drop-popover'>
          <ul>
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
