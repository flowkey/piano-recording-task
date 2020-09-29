module.exports = {
    root: true,
    env: { browser: true, es6: true },
    parser: "@typescript-eslint/parser",
    plugins: ["@typescript-eslint", "react", "prettier"],
    rules: {
        "prettier/prettier": "error",
        "@typescript-eslint/explicit-module-boundary-types": "off",
        "@typescript-eslint/no-unused-vars": "off",
        "@typescript-eslint/no-unused-vars-experimental": "error",
    },
    extends: [
        "prettier",
        "eslint:recommended",
        "plugin:@typescript-eslint/eslint-recommended",
        "plugin:@typescript-eslint/recommended",
        "plugin:react/recommended",
        "prettier/@typescript-eslint",
    ],
};
