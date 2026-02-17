#!/usr/bin/env bun

/**
 * based on:
 * https://zenn.dev/pnd/articles/claude-code-statusline
 */

const formatTokenCount = (tokens: number): string =>
	tokens >= 1000000
		? `${(tokens / 1000000).toFixed(1)}M`
		: tokens >= 1000
			? `${(tokens / 1000).toFixed(1)}K`
			: tokens.toString();

const buildStatusLine = (input: string): string => {
	const data = JSON.parse(input);
	const model = data.model?.display_name || "Unknown";
	const currentDir = data.workspace?.current_dir;

	const contextWindow = data.context_window || {};
	const contextSize = contextWindow.context_window_size;
	const currentUsage = contextWindow.current_usage;
	const autoCompactLimit = contextSize * 0.8;

	const currentTokens =
		(currentUsage.input_tokens || 0) +
		(currentUsage.cache_creation_input_tokens || 0) +
		(currentUsage.cache_read_input_tokens || 0);

	const percentage = Math.min(
		100,
		Math.round((currentTokens / autoCompactLimit) * 100),
	);
	const tokenDisplay = formatTokenCount(currentTokens);

	const resetStyle = "\x1b[38;5;246m";
	const percentageColor =
		percentage >= 90
			? "\x1b[31m" // Red
			: percentage >= 70
				? "\x1b[33m" // Yellow
				: "\x1b[32m"; // Green

	return `${resetStyle}${model} | ${percentageColor}${percentage}%${resetStyle} - ${tokenDisplay} | ${currentDir}`;
};

const chunks: Array<Buffer<ArrayBufferLike>> = [];
process.stdin.on("data", (chunk) => chunks.push(chunk));
process.stdin.on("end", () => console.log(buildStatusLine(chunks.join(""))));
