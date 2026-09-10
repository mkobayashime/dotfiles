## Commands

- linter/formatter/typechecker など
  - 必ず以下のフローで適切なコマンドを探す
  - プロジェクトの `Makefile` 内に似たコマンドがないか探す
    - ある場合、`make <target>` でそのまま実行するか、オプションや引数の変更が必要な場合は make target に指定されているコマンドを参考にする
  - `Makefile` や適切な make target がない場合
    - npm package は yarn や bunx、npx で実行する
      - `yarn.lock` ファイルが存在する場合: yarn を使用 (e.g. `yarn tsc`)
      - `bun.lock`/`bun.lockb` ファイルが存在する場合: Bun を使用 (e.g. `bunx tsc`)
      - `package-lock.json` ファイルが存在する場合: npx を使用 (e.g. `npx tsc`)
