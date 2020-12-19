import React, { useEffect, useState } from "react";
import Level from "./components/Level";
import NodeForm from "./components/NodeForm";
import csrfToken from "./modules/csrfToken";

const App = () => {
  const [action, setAction] = useState("index");
  const [nodes, setNodes] = useState(null);
  const [editingNode, setEditingNode] = useState(null);
  const [newNodeAttributes, setNewNodeAttributes] = useState(null);
  useEffect(() => {
    switch (action) {
      case "index": {
        fetch("/nodes", {
          method: "GET",
          headers: new window.Headers({
            "Content-Type": "application/json; charset=utf-8",
            Accept: "application/json"
          }),
        })
          .then((resp) => resp.json())
          .then((data) => {
            setNodes(data);
          });
        break;
      }
      case "update": {
        fetch(`/nodes/${editingNode.id}`, {
          method: "PATCH",
          headers: new window.Headers({
            "Content-Type": "application/json; charset=utf-8",
            Accept: "application/json",
            "X-CSRF-TOKEN": csrfToken
          }),
          body: JSON.stringify({ node: newNodeAttributes })
        })
          .then(resp => {
            if (resp.status === 200) {
              setNewNodeAttributes(null);
              setEditingNode(null);
              setAction("index");
            } else {
              alert("Your changes could not be saved. Please contact an administrator if the problem continues.");
            }
          });
      }
    }
  }, [action]);

  const saveNode = attributes => {
    if (!editingNode) return;;
    setNewNodeAttributes(attributes);
    setAction("update");
  };

  const launchNodeForm = nodeId => {
    const node = nodes.find(node => node.id === nodeId);
    setEditingNode(node);
  };

  const closeNodeForm = () => setEditingNode(null);

  return (
    <>
      <h1>Org Chart</h1>
      {nodes ? (
        <>
          <Level
            handleLaunchNodeForm={launchNodeForm}
            nodes={nodes}
            parent={nodes.find((node) => node.root)}
          />
          <NodeForm
            editingNode={editingNode}
            handleCancel={closeNodeForm}
            handleSave={saveNode}
            nodes={nodes}
          />
        </>
      ) : (
        "loading..."
      )}
    </>
  );
};

export default App;
