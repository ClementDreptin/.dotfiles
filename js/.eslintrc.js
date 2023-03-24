/** @type {import('eslint').Linter.Config} */
module.exports = {
  extends: 'standard',
  parserOptions: {
    ecmaVersion: 'latest',
  },
  rules: {
    semi: ['error', 'always'],
    'no-extra-semi': 'error',
    'comma-dangle': ['error', 'always'],
  },
};
