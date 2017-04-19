import React from 'react';
import ReactDOM from 'react-dom';

export default class Mounter {
  constructor(selector, component) {
    this.selector = selector;
    this.component = component;
  }

  mount() {
    const $el = document.querySelector(this.selector);
    const Component = this.component;
    if ($el) {
      ReactDOM.render(<Component />, $el);
    }
  }

  unmount() {
    const $el = document.querySelector(this.selector);
    if ($el) {
      ReactDOM.unmountComponentAtNode($el);
    }
  }
}
