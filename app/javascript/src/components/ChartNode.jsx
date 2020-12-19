import React from "react";
import PropTypes from "prop-types";
import { FiEdit } from "react-icons/fi";

const propTypes = {
  first_name: PropTypes.string,
  handleLaunchForm: PropTypes.func,
  id: PropTypes.number,
  last_name: PropTypes.string,
  root: PropTypes.bool
};

const ChartNode = props => {
  const launchForm = e => {
    e.preventDefault();
    props.handleLaunchForm(props.id);
  };

  const name = props.last_name
    ? (
      <div className="name">
        {props.first_name} {props.last_name}
        {props.root
          ? null
          : (
            <a href="#" onClick={launchForm} title="Edit">
              <FiEdit />
            </a>
          )
        }
      </div>
    )
    : null

  return (
    <>
      {name}
    </>
  );
};

ChartNode.propTypes = propTypes;

export default ChartNode;
