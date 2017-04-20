import React from 'react';
import PropTypes from 'prop-types';

const InverseCard = ({ children, skin }) => (
  <div className={`card card-inverse card-${skin}`}>
    { children }
  </div>
);

InverseCard.defaultProps = {
  skin: 'primary',
};

InverseCard.propTypes = {
  children: PropTypes.node.isRequired,
  skin: PropTypes.string,
};

export default InverseCard;
