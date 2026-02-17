#!/usr/bin/env bun

import {
	lstatSync,
	mkdirSync,
	readdirSync,
	readFileSync,
	rmSync,
	symlinkSync,
	writeFileSync,
} from "node:fs";
import { homedir } from "node:os";
import { join } from "node:path";

const DOTPATH = join(homedir(), "dotfiles");
const HOME = homedir();

const forceSymlink = ({ source, dest }: { source: string; dest: string }) => {
	try {
		lstatSync(dest);
		rmSync(dest, { recursive: true });
	} catch {}
	symlinkSync(source, dest);
	console.log(`  ${dest} -> ${source}`);
};

const mergeJsonConfig = ({
	basePath,
	localPath,
	outputPath,
}: {
	basePath: string;
	localPath: string;
	outputPath: string;
}) => {
	const base = JSON.parse(readFileSync(basePath, "utf-8"));
	let merged = base;
	try {
		const local = JSON.parse(readFileSync(localPath, "utf-8"));
		merged = { ...base, ...local };
	} catch {}
	writeFileSync(outputPath, JSON.stringify(merged, null, 2));
	console.log(`  merged -> ${outputPath}`);
};

const deploySharedSkills = ({
	targetSkillsDir,
}: {
	targetSkillsDir: string;
}) => {
	mkdirSync(targetSkillsDir, { recursive: true });
	const skillsDir = join(DOTPATH, "agents/skills");
	for (const skill of readdirSync(skillsDir)) {
		forceSymlink({
			source: join(skillsDir, skill),
			dest: join(targetSkillsDir, skill),
		});
	}
};

// --- Claude Code ---
console.log("=== Claude Code ===");
for (const target of [
	join(HOME, ".config/claude"),
	join(HOME, ".config/claude-herp"),
]) {
	console.log(`[${target}]`);
	mkdirSync(join(target, "skills"), { recursive: true });

	for (const name of ["statusline.ts", "agents", "commands"] as const) {
		forceSymlink({
			source: join(DOTPATH, "agents/claude", name),
			dest: join(target, name),
		});
	}

	deploySharedSkills({ targetSkillsDir: join(target, "skills") });

	mergeJsonConfig({
		basePath: join(DOTPATH, "agents/claude/settings.base.json"),
		localPath: join(target, "settings.local.json"),
		outputPath: join(target, "settings.json"),
	});
}

// --- Cursor ---
console.log("=== Cursor ===");
for (const target of [join(HOME, ".cursor")]) {
	console.log(`[${target}]`);
	mkdirSync(join(target, "skills"), { recursive: true });

	forceSymlink({
		source: join(DOTPATH, "agents/cursor/hooks.json"),
		dest: join(target, "hooks.json"),
	});
	forceSymlink({
		source: join(DOTPATH, "agents/cursor/hooks"),
		dest: join(target, "hooks"),
	});

	deploySharedSkills({ targetSkillsDir: join(target, "skills") });

	mergeJsonConfig({
		basePath: join(DOTPATH, "agents/cursor/cli-config.base.json"),
		localPath: join(target, "cli-config.local.json"),
		outputPath: join(target, "cli-config.json"),
	});
}

// --- opencode ---
console.log("=== opencode ===");
for (const target of [join(HOME, ".config/opencode")]) {
	console.log(`[${target}]`);
	mkdirSync(target, { recursive: true });

	forceSymlink({
		source: join(DOTPATH, "agents/opencode/plugins"),
		dest: join(target, "plugins"),
	});
	forceSymlink({
		source: join(DOTPATH, "agents/skills"),
		dest: join(target, "skills"),
	});
}
