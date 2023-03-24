/** @type {import('eslint').Linter.Config} */
module.exports = {
  extends: 'standard-with-typescript',
  parserOptions: {
    project: './tsconfig.json',
  },
  rules: {
    // Note: the default 'semi' rule is disabled because '@typescript-eslint/semi' extends it and having
    // both enabled at the same time reports incorrect errors.
    semi: 'off',
    '@typescript-eslint/semi': ['error', 'always'],
    '@typescript-eslint/member-delimiter-style': [
      'error',
      {
        multiline: { delimiter: 'semi', requireLast: true },
        singleline: { delimiter: 'semi', requireLast: true },
      },
    ],
    'no-extra-semi': 'error',
    'comma-dangle': ['error', 'always-multiline'],
  },
};
