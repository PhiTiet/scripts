#!/bin/bash
# this script reverts all commits which contain the two messages in the commit message, it then squashes and commits the message without pushing it.

msg1="8787330"
msg2="8219515"

# Get the list of commit hashes and timestamps containing the specified messages
commits1=$(git log --grep="$msg1" --format="%ct %H")
commits2=$(git log --grep="$msg2" --format="%ct %H")

# Combine and sort the commit hashes by time, then remove the time
all_commits=$(echo -e "${commits1}\n${commits2}" | sort -rn | cut -d' ' -f2 | uniq)

for commit in $all_commits; do
  git revert --no-edit -m 1 $commit
done

num_reverts=$(echo "$all_commits" | wc -l | tr -d ' ')

if [ $num_reverts -gt 0 ]; then
  git reset --soft HEAD~$num_reverts
  git commit --no-edit -m "REVERTING: Squashed $num_reverts revert commits"
fi
