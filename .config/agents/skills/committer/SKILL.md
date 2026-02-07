---
name: committer
description: Commit uncommitted codebase changes
allowed-tools: Bash(git rev-parse:*) Bash(git log:*) Bash(git show:*) Bash(git diff:*) Bash(git commit:*)
---

Commit changes in multiple, semantically distinct commits. Follow the steps below in order.

## 1. Determine scope

- If the user has staged specific files, commit only those staged changes — unless they explicitly ask to include more.
- Otherwise, commit all uncommitted changes.

## 2. Group changes into logical commits

Split the changes into separate commits based on these criteria:

- **Functionality** — group changes that belong to the same feature or concern together.
- **Phase of work** — separate changes that represent different stages (e.g. implementation vs. refinement).
- **Docs vs. code** — never mix documentation changes with code changes in the same commit.

## 3. Commit in the right order

- If there are uncommitted docs related to the current task, commit them first as a standalone commit.
- Then commit the remaining groups in a logical sequence.
