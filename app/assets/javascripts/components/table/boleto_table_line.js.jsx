var BoletoTableLine = React.createClass({

  propTypes: {
    boleto: React.PropTypes.object.isRequired,
    onDelete: React.PropTypes.func.isRequired
  },

  onDelete(e) {
    e.preventDefault();
    $.ajax({
      type: 'delete',
      url: "/boletos/" + this.props.boleto.id,
      dataType: 'json',
      success: () => this.props.onDelete(this.props.boleto),
      error: error => console.log(error)
    });
  },

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
            <a href={"/boletos/generate." + this.props.boleto.id} target="_blank">
              <i className="tiny material-icons">print</i>
            </a>
            <a data-confirm="Are you sure?" rel="nofollow" onClick={this.onDelete} href="#">
              <i className="tiny material-icons">delete</i>
            </a>
          </td>
        </tr>
    );
  }
});
