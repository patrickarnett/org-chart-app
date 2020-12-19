const csrfElement = document.querySelector("[name=csrf-token]");
const csrfToken = csrfElement ? csrfElement.content : "";
export default csrfToken;
