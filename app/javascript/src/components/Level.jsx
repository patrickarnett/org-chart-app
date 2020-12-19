import React from "react";
import PropTypes from "prop-types";
import ChartNode from "./ChartNode";

const hasChildren = ({ node, nodes }) =>
  nodes.some((item) => item.parent_id === node.id);
const getChildren = ({ node, nodes }) =>
  nodes.filter((item) => item.parent_id === node.id);

const propTypes = {
  handleLaunchNodeForm: PropTypes.func,
  nodes: PropTypes.array,
  parent: PropTypes.object
};

const Level = ({ handleLaunchNodeForm, nodes, parent }) => {
  const chartNode = (
    <ChartNode
      {...parent}
      handleLaunchForm={handleLaunchNodeForm}
    />
  );

  if (!hasChildren({ nodes, node: parent })) {
    return chartNode;
  }

  return (
    <>
      {chartNode}
      <ul>
        {getChildren({ node: parent, nodes }).map((child) => (
          <li key={child.id}>
            <Level
              handleLaunchNodeForm={handleLaunchNodeForm}
              nodes={nodes}
              parent={child}
            />
          </li>
        ))}
      </ul>
    </>
  );
};

Level.propTypes = propTypes;

export default Level;
