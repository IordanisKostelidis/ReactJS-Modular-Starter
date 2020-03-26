import React, { Component } from 'react'
import PropTypes from 'prop-types'

export class FullName extends Component {
  static propTypes = {
    firstName: PropTypes.string,
    lastName: PropTypes.string
  };

  render() {
    const { firstName, lastName } = this.props

    return (
      <div>
        {firstName} {lastName}
      </div>
    )
  }
}
