import React, { Component } from 'react'
import PropTypes from 'prop-types'

export class Role extends Component {
  static propTypes = {
    name: PropTypes.string
  };

  render() {
    const { name } = this.props

    return (
      <div>
        {name}
      </div>
    )
  }
}
