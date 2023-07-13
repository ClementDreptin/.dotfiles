const path = require("path");

/** @type {import('eslint').Linter.Config} */
module.exports = {
  extends: ["standard-with-typescript", "prettier"],
  parserOptions: {
    project: path.join(__dirname, "tsconfig.json"),
  },
  rules: {
    "@typescript-eslint/explicit-function-return-type": "off",
  },
};
