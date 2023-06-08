import React from "react"
import PropTypes from "prop-types"
class PageTitle extends React.Component {
  render() {
    return (
      <div className="page-title-react">
        <h3>
          {this.props.title}
        </h3>
      </div>
    );
  }
}

PageTitle.propTypes = {
  title: PropTypes.string
};
export default PageTitle
