import { defineConfig } from "oxfmt";

export default defineConfig({
	useTabs: true,
	sortImports: true,
	// Vendored code (git submodules) and a plugin-manager-generated lockfile;
	// not ours to reformat.
	ignorePatterns: [
		".config/tmux/plugins/tpm/**",
		".config/zsh/antigen/**",
		".config/zsh/pure/**",
		".config/nvim/lazy-lock.json",
	],
});
