---
name: committer
description: The required path for every commit — use it whenever the user asks to commit, including compound requests ("branch, commit, and push", "commit then PR") and changes that only need a single commit. Never run `git commit` directly. Groups staged or unstaged changes into semantically distinct commits, splitting by feature, work phase, and docs vs. code, and commits in the right order.
allowed-tools: Bash(git rev-parse:*) Bash(git log:*) Bash(git show:*) Bash(git diff:*) Bash(git commit:*)
---

Create one or more semantically distinct commits. Follow the steps below in order.

This skill is **always** the path for committing — including when the request is one step
of a larger sequence (e.g. "branch, commit, PR") and when the change is small. A single
commit is a valid outcome when the change is one cohesive unit; splitting is a tool to
apply when it helps, not a requirement.

# Context

## Log

```
!`git log --no-merges -10`
```

## Status

```
!`git status`
```

# Steps

## 1. Determine scope

- If the user has staged specific files, commit only those staged changes — unless they explicitly ask to include more.
- Otherwise, commit all uncommitted changes.

## 2. Group changes into logical commits

If the changes are all one cohesive concern, a single commit is correct — do not split
just to produce more commits. Otherwise, split into separate commits based on these
criteria:

- **Functionality** — group changes that belong to the same feature or concern together.
- **Phase of work** — separate changes that represent different stages (e.g. implementation vs. refinement).
- **Docs vs. code** — never mix documentation changes with code changes in the same commit.

## 3. Commit in the right order

- If there are uncommitted docs related to the current task, commit them first as a standalone commit.
- Then commit the remaining groups in a logical sequence.
- Write the commit message **in English**, unless other language like Japanese is specified.
- Decide whether to use [Conventional Commits](https://www.conventionalcommits.org/) based on the recent 10 commits in the Context above: if a majority of them follow Conventional Commits, follow that style; otherwise, do not adopt it.
