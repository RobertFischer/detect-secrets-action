# Detect Secrets Action

This github action scans a repository usuing Yelp's [Detect Secrets](https://github.com/Yelp/detect-secrets) library.

## Sample Configuration

This file is accessible at `./.github/workflows/main.yml` in the action's repository.

```
---

# This runs Yelp's 'detect-secrets': https://github.com/Yelp/detect-secrets/blob/master/README.md

name: Scan Code for Secrets

on:
  pull_request:
    types: [opened, reopened, ready_for_review, synchronize]
  push:
    branches:
      - '**'
    tags:
      - '!**'

jobs:
  check-for-secrets:
    runs-on: 'ubuntu-latest'
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Run Yelp's detect-secrets
        uses: RobertFischer/detect-secrets-action@v2.0.0
      - name: Commit back .secrets.baseline (if it was missing)
        uses: stefanzweifel/git-auto-commit-action@v4
        with:
          commit_message: "build(detect-secrets): Commit the newly-generated .secrets.baseline file"
```

## Environment Variables

| Key  | Value Description | Default Value |
| ---- | ----------------- | ------------- |
| `DS_ADDL_ARGS` | Additional arguments to pass to the `detect-secrets` binary | No additional arguments (ie: the empty string) |
| `DS_REQUIRE_BASELINE` | If set to anything other than `0`, we will fail the test if there is no baseline file | `0` (ie: don't require baseline) ]

## Usage Notes

If this action runs and does not see a `detect-secrets` baseline file at `.secrets.baseline` in the root of the repo, then the action will generate that baseline file for you.
If you don't commit that file back, then this action is effectively an expensive no-op. The sample configuration above demonstrates how to commit back using the
(`git-auto-commit`)[https://github.com/marketplace/actions/git-auto-commit] action.
