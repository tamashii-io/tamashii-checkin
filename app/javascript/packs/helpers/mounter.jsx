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
      const dataset = $el.dataset;
      ReactDOM.render(<Component {...dataset} />, $el);
    }
  }

  unmount() {
    const $el = document.querySelector(this.selector);
    if ($el) {
      ReactDOM.unmountComponentAtNode($el);
    }
  }
}
