import eslint from "@eslint/js";
import neostandard from "neostandard";
import tseslint from "typescript-eslint";

export default tseslint.config(
  // Base
  eslint.configs.recommended,

  // Standard
  ...neostandard({ noStyle: true }),

  // TypeScript
  ...tseslint.configs.strictTypeChecked,
  ...tseslint.configs.stylisticTypeChecked,
  {
    languageOptions: {
      parserOptions: {
        project: "./tsconfig.json",
      },
    },
  },

  // Custom rules
  {
    rules: {
      "@typescript-eslint/strict-boolean-expressions": [
        "error",
        {
          allowString: false,
          allowNumber: false,
          allowNullableObject: false,
          allowNullableBoolean: false,
          allowNullableString: false,
          allowNullableNumber: false,
          allowAny: false,
        },
      ],
      "@typescript-eslint/consistent-type-imports": [
        "error",
        {
          fixStyle: "inline-type-imports",
        },
      ],
    },
  },

  // Disable type-aware linting for config files
  {
    files: ["*.config.{js,ts,mjs}"],
    extends: [tseslint.configs.disableTypeChecked],
  },
);
