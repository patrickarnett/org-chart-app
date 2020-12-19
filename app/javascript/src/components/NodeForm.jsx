import React, { useState } from "react";
import PropTypes from "prop-types";
import PopUp from "reactjs-popup";
import "reactjs-popup/dist/index.css";

const getAncestors = ({ node, nodes }) => {
  var ancestor = node;
  const ancestors = [];
  while (ancestor.parent_id && !ancestors.includes(ancestor.parent_id)) {
    ancestors.push(ancestor.parent_id);
    ancestor = nodes.find(node => node.id === ancestor.parent_id);
  }
  return ancestors;
};

const propTypes = {
  editingNode: PropTypes.shape({
    first_name: PropTypes.string,
    last_name: PropTypes.string,
    parent_id: PropTypes.number
  }),
  handleCancel: PropTypes.func,
  handleSave: PropTypes.func,
  nodes: PropTypes.arrayOf(PropTypes.shape({
    first_name: PropTypes.string,
    last_name: PropTypes.string,
    id: PropTypes.number,
    parent_id: PropTypes.number
  }))
};

const NodeForm = ({ editingNode, handleCancel, handleSave, nodes }) => {
  if (!editingNode) return null;

  const [parentId, setParentId] = useState(editingNode.parent_id);

  const handleChangeParentId = e => {
    const newParentId = e.currentTarget.value;
    setParentId(newParentId);
  };

  const cancel = e => {
    e.preventDefault();
    handleCancel();
  };

  const save = e => {
    e.preventDefault();
    handleSave({ parent_id: parentId });
  };

  return (
    <PopUp
      open={true}
      closeOnDocumentClick
      onClose={handleCancel}
    >
      <form>
        <h3>Editing {editingNode.first_name} {editingNode.last_name}</h3>

        <div>
          <label htmlFor="parent-node">
            Parent
          </label>
        </div>

        <div>
          <select
            id="parent-node"
            onChange={handleChangeParentId}
            value={parentId}
          >
            {nodes.map((node) => {
              return node.id === editingNode.id || getAncestors({node, nodes}).includes(editingNode.id)
                ? null
                : (
                  <option key={node.id} value={node.id}>
                    {node.first_name} {node.last_name}
                  </option>
                );
            })}
          </select>
        </div>

        <div>
          <button onClick={save}>
            Save
          </button>
        </div>

        <div>
          <button onClick={cancel}>
            Cancel
          </button>
        </div>
      </form>
    </PopUp>
  );
};

NodeForm.propTypes = propTypes;

export default NodeForm;
