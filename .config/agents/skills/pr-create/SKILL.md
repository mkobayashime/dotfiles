---
name: pr-create
description: Create a new Pull Request from current branch
allowed-tools: Bash(git rev-parse:*) Bash(git log:*) Bash(git show:*) Bash(git diff:*) Bash(git push:*) Bash(gh pr:*)
---

When prompted to create a new Pull Request from current branch,

- Ignore uncommitted changes.
- Specify proper title: It should be a summary of all changes made against the target branch, not some specific commit.
- If the repository has Pull Request template (typically in `.github/pull_request_template.md`), respect it.
