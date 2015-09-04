var BoletoTableLine = React.createClass({

  render: function() {
    return (
        <tr>
          <td>{this.props.boleto.date}</td>
          <td>{this.props.boleto.maturity}</td>
          <td>{this.props.boleto.doc_number}</td>
          <td>{this.props.boleto.client}</td>
          <td>{this.props.boleto.amount}</td>
          <td>{this.props.boleto.discount}</td>
          <td>
            <i className="tiny material-icons">print</i>
            <i className="tiny material-icons">loop</i>
            <i className="tiny material-icons">delete</i>
          </td>
        </tr>
    );
  }
});
