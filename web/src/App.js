import React from 'react';
import babble from './assets/babble.png';
import patreon from './assets/patreon.png';
import trello from './assets/trello.png';
import twitter from './assets/twitter.png';
import github from './assets/github.png';
import './App.scss';
// import {Twitter, GitHub} from '@material-ui/icons';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={babble} className="App-logo" alt="logo" />
        <h1>Welcome to Babble</h1>
        <p>My Devs are working hard to get me up and running. in the mean time you can find me here</p>
        <ul className="Social-Icons">
          <li><a href="https://twitter.com/BABBLECHATBOT"><img src={twitter} alt="twitter"/></a></li>
          <li><a href="https://trello.com/b/ouoA0dci/babble-roadmap"><img src={trello} alt="trello"/></a></li>
          <li><a href="https://www.patreon.com/babblechatbot"><img src={patreon} alt="patreon"/></a></li>
          <li><a href="https://github.com/Babble-Bot/thetabot"><img src={github} alt="github"/></a></li>
        </ul>
      </header>
    </div>
  );
}

export default App;
