module.exports = {
  "root": true,
  "env": {
    es6: true,
    node: true,
  },
  "extends": [
    "eslint:recommended",
    "google",
  ],
  "parserOptions": {
    "ecmaVersion": 11,
  },
  "rules": {
    "no-trailing-spaces": ["error"],
    "eol-last": ["error"],
    "quotes": ["error", "double"],
    "max-len": [
      "error",
      {
        "code": 100,
      },
    ],
  },
};
