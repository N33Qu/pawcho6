import React from 'react';
import './App.css';

export const ver = process.env.REACT_APP_VERSION;

function App() {
  const getHostname = () => {
    return window.location.hostname;
  };

  const getAddress = () => {
    return window.location.clientId;
  };

  return (
      <div className="App">
        <header className="App-header">
          <p>Hostname: {getHostname()}</p>
          <p>Adres: {getAddress()}</p>
          <p>Wersja: {ver}</p>
        </header>
      </div>
  );
}

export default App;
