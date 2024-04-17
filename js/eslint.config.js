import { FlatCompat } from "@eslint/eslintrc";
import eslint from "@eslint/js";
import prettierConfig from "eslint-config-prettier";
import standardConfig from "eslint-config-standard";
import tseslint from "typescript-eslint";

const compat = new FlatCompat();

export default tseslint.config(
  // Base
  eslint.configs.recommended,

  // Standard
  // necessary to transform to flat config until the npm packages are updated
  ...compat.config(standardConfig),

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

  // Prettier
  prettierConfig,

  // Disable type-aware linting for config files
  {
    files: ["*.config.[j|t]s"],
    extends: [tseslint.configs.disableTypeChecked],
  },
);
