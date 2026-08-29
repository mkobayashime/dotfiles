---
name: pr-create
description: The required path for creating a Pull Request — use it whenever the user asks for a PR, including as one step of a multi-step request ("branch, commit, PR"). Never run `gh pr create` directly. Creates a PR from the current branch to the target, writes a title summarizing all branch changes (not a single commit), respects PR templates, and ignores uncommitted changes.
allowed-tools: Bash(git rev-parse:*) Bash(git log:*) Bash(git show:*) Bash(git diff:*) Bash(git push:*) Bash(gh pr:*)
---

# Context

##  Log

```
!`git log -20`
```

## Status

```
!`git status`
```

## Pull Request template

```
!`fd --hidden pull_request_template.md "$(git rev-parse --show-toplevel)" | grep . || echo "no template"`
```

# Task

When prompted to create a new Pull Request from current branch,

- This skill is **always** the path for creating a PR — including when it is one step of a
  larger request ("branch, commit, PR"). Do not fall back to a bare `gh pr create`.
- If the current task still has uncommitted changes that should land in this PR, run the
  `committer` skill to commit them first, then continue here.
- Ignore uncommitted changes that are not part of this task.
- Specify proper title: It should be a summary of all changes made against the target branch, not some specific commit.
- If there is a Pull Request template, respect it.
