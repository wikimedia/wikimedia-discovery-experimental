cd /srv/dashboards

# We need to check if the experimental dashboards
# repo has been updated (e.g. packages added to
# setup.sh). Only then can we pull latest versions
# of dashboards.

# Bring remote references up to date:
git fetch origin

# Check if there are remote changes that
# need to be merged in:
MERGES=$(git log HEAD..origin/master --oneline)
if [ ! -z "$MERGES" ]; then
  CHANGES=$(git diff --shortstat)
  if [ ! -z "$CHANGES" ]; then
    # Clean out uncommitted references to dashboards:
    git submodule update --init
    # ^ avoids conflicts when pulling origin/master
  fi
  # Bring this repo up-to-date:
  git pull origin master
  # Re-provision the vagrant container:
  bash setup.sh
fi

# Pull latest version of each dashboard:
git submodule foreach git pull origin master

# Check if newer ver's of dashboards were downloaded...
# ...but first let's ensure we don't get an error:
if [ ! -e '/home/bearloga/submodules_status.txt' ]; then
  touch /home/bearloga/submodules_status.txt
fi
# ...okay, let's actually do the check now:
OLDSTATUS=`cat /home/bearloga/submodules_status.txt`
NEWSTATUS=$(git submodule status)
if [ "$OLDSTATUS" != "$NEWSTATUS" ]; then
  # Restart because different (newer?) dashboards were dl'd:
  service shiny-server restart
  # Save hashes for next checkup:
  git submodule status > /home/bearloga/submodules_status.txt
fi
