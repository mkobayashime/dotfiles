#!/usr/bin/env bun

import { readFileSync, writeFileSync } from "node:fs";
import { homedir } from "node:os";
import path from "node:path";

const DOTPATH = path.join(homedir(), "dotfiles");
const HOME = homedir();

const syncConfig = ({
	livePath,
	basePath,
	localPath,
	excludeKeys,
}: {
	livePath: string;
	basePath: string;
	localPath: string;
	excludeKeys: string[];
}) => {
	const live = JSON.parse(readFileSync(livePath, "utf-8"));

	const base = { ...live };
	for (const key of excludeKeys) delete base[key];

	const local: Record<string, unknown> = {};
	for (const key of excludeKeys) {
		if (key in live) local[key] = live[key];
	}

	writeFileSync(basePath, JSON.stringify(base, null, 2));
	writeFileSync(localPath, JSON.stringify(local, null, 2));

	console.log(`Synced: ${livePath}`);
	console.log(`  base  -> ${basePath}`);
	console.log(`  local -> ${localPath}`);
};

const syncClaude = ({ src }: { src: string }) =>
	syncConfig({
		livePath: path.join(src, "settings.json"),
		basePath: path.join(DOTPATH, "agents/claude/settings.base.json"),
		localPath: path.join(src, "settings.local.json"),
		excludeKeys: ["env", "model"],
	});

const syncCursor = ({ src }: { src: string }) =>
	syncConfig({
		livePath: path.join(src, "cli-config.json"),
		basePath: path.join(DOTPATH, "agents/cursor/cli-config.base.json"),
		localPath: path.join(src, "cli-config.local.json"),
		excludeKeys: ["authInfo", "privacyCache", "model"],
	});

const [command, sourceDir] = process.argv.slice(2);

switch (command) {
	case "claude":
		syncClaude({ src: sourceDir ?? path.join(HOME, ".config/claude") });
		break;
	case "cursor":
		syncCursor({ src: sourceDir ?? path.join(HOME, ".cursor") });
		break;
	case "all":
		syncClaude({ src: path.join(HOME, ".config/claude") });
		syncClaude({ src: path.join(HOME, ".config/claude-herp") });
		syncCursor({ src: path.join(HOME, ".cursor") });
		break;
	default:
		console.log("Usage: sync.ts {claude|cursor|all} [source_dir]");
		console.log("  claude  - sync from ~/.config/claude");
		console.log("  cursor  - sync from ~/.cursor");
		console.log("  all     - sync all profiles");
		process.exit(1);
}
