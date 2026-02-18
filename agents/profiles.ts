import { homedir } from "node:os";
import path from "node:path";

export const HOME = homedir();
export const DOTPATH = path.join(HOME, "dotfiles");

type SyncConfig = {
	configFile: string;
	basePath: string;
	excludeKeys: string[];
};

export type AgentProfile = {
	name: "claude" | "cursor" | "opencode";
	targets: string[];
	sync?: SyncConfig;
};

export const agents: AgentProfile[] = [
	{
		name: "claude",
		targets: [
			path.join(HOME, ".config/claude"),
			path.join(HOME, ".config/claude-herp"),
		],
		sync: {
			configFile: "settings.json",
			basePath: path.join(DOTPATH, "agents/claude/settings.base.json"),
			excludeKeys: ["env", "model"],
		},
	},
	{
		name: "cursor",
		targets: [path.join(HOME, ".config/cursor")],
		sync: {
			configFile: "cli-config.json",
			basePath: path.join(DOTPATH, "agents/cursor/cli-config.base.json"),
			excludeKeys: ["authInfo", "privacyCache", "model"],
		},
	},
	{
		name: "opencode",
		targets: [path.join(HOME, ".config/opencode")],
	},
];
