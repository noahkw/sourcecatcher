#! /bin/bash

set -e

read -p "This will reset the current database. Are you sure you want to continue? (y/n) " -n 1 -r
echo    # (optional) move to a new line


if [[ $REPLY =~ ^[Yy]$ ]]
then
  rm -f twitter_scraper.db
  rm -f phash_index.ann

  source ./sourcecatcher_venv/bin/activate
  python bot.py
  python gen_phashes.py

  LIVE_DIR=live/
  WORKING_DIR=working/
  mkdir -p $LIVE_DIR
  mkdir -p $WORKING_DIR

  cp $WORKING_DIR/twitter_scraper.db $LIVE_DIR
  cp $WORKING_DIR/phash_index.ann $LIVE_DIR
fi
