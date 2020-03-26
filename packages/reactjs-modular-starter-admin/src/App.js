import React from 'react'
import logo from './logo.svg'
import './App.css'
import { FullName, Role } from 'reactjs-modular-starter-components'

function App () {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <Role name="Admin"/>
        <FullName firstName="Iordanis" lastName="Kostelidis"/>
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  )
}

export default App
