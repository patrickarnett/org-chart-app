// import "core-js/stable";
// import "regenerator-runtime/runtime";

import React from "react";
import ReactDOM from "react-dom";
import App from "../src/App";

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(
    <App />,
    document.body.appendChild(document.createElement("div"))
  );
});
