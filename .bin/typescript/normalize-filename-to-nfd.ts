#!/usr/bin/env bun

import { rename } from "node:fs/promises";

const files = process.argv.slice(2);

for (const file of files) {
	const tmp = `${file}.tmp`;
	const normalized = file.normalize("NFD");

	await rename(file, tmp);
	await rename(tmp, normalized);
}
