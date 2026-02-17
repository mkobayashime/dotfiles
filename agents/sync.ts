#!/usr/bin/env bun

import { readFileSync, writeFileSync } from "node:fs";
import path from "node:path";
import { $ } from "bun";
import { agents, DOTPATH } from "./profiles.ts";

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

const syncTarget = ({ target, name }: { target: string; name: string }) => {
	const agent = agents.find((a) => a.name === name);
	if (!agent?.sync) return;
	const { configFile, basePath, excludeKeys } = agent.sync;
	syncConfig({
		livePath: path.join(target, configFile),
		basePath,
		localPath: path.join(
			target,
			`${configFile.replace(/\.json$/, "")}.local.json`,
		),
		excludeKeys,
	});
};

const [command, sourceDir] = process.argv.slice(2);

switch (command) {
	case "claude":
	case "cursor": {
		const agent = agents.find((a) => a.name === command);
		if (!agent) break;
		syncTarget({ target: sourceDir ?? agent.targets[0], name: command });
		break;
	}
	case "all":
		for (const agent of agents) {
			if (!agent.sync) continue;
			for (const target of agent.targets) {
				syncTarget({ target, name: agent.name });
			}
		}
		break;
	default:
		console.log("Usage: sync.ts {claude|cursor|all} [source_dir]");
		console.log("  claude  - sync from ~/.config/claude");
		console.log("  cursor  - sync from ~/.cursor");
		console.log("  all     - sync all profiles");
		process.exit(1);
}

await $`bunx --bun biome check --write ${path.join(DOTPATH, "agents")}`;
