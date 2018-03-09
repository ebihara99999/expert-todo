module.exports = {
  "extends": [
    "google",
    "plugin:vue/essential",
    "plugin:vue/recommended",
    "plugin:vue/strongly-recommended",
  ],
  "env": {
    "node": true,
    "es6": true
  },
  "rules": {
    // 改行コードはUnix
    "linebreak-style": ["error", "unix"],
    "max-len": ["error", { "code": 100 }],
  },
  "parserOptions": {
    "sourceType": "module"
  }
}