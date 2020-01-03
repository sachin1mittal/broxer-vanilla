import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import { createBrowserHistory } from 'history';
import { Router, Route, Switch } from 'react-router-dom';

import './assets/scss/material-kit-react.scss';

// pages for this product
import LandingPage from './views/LandingPage/LandingPage.js';
import ProfilePage from './views/ProfilePage/ProfilePage.js';
import LoginPage from './views/LoginPage/LoginPage.js';

var hist = createBrowserHistory();

ReactDOM.render(
  <Router history={hist}>
    <Switch>
      <Route path='/landing-page' component={LandingPage} />
      <Route path='/profile-page' component={ProfilePage} />
      <Route path='/login-page' component={LoginPage} />
      <Route path='/' component={App} />
    </Switch>
  </Router>,
  document.getElementById('root')
);

