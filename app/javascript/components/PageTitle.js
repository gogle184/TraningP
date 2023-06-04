import React from "react"
import PropTypes from "prop-types"
class PageTitle extends React.Component {
  render() {
    return (
      <div className="page-title-react">
        <h2>
          {this.props.title}
        </h2>
      </div>
    );
  }
}

PageTitle.propTypes = {
  title: PropTypes.string
};
export default PageTitle
