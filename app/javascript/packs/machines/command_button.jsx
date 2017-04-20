import React from 'react';
import PropTypes from 'prop-types';

// TODO: Bind ajax:success event for command result
const CommandButton = ({ name, skin, link, command }) => (
  <a
    className={`btn btn-${skin}`}
    data-remote="true"
    data-method="post"
    href={`${link}?command=${command}`}
  >{name}</a>
);

CommandButton.propTypes = {
  link: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  skin: PropTypes.string.isRequired,
  command: PropTypes.string.isRequired,
};

export default CommandButton;
