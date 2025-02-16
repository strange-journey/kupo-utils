#!/bin/bash
set -o pipefail

# symlink all torrents tagged with 'shoko' to shoko directory
rtcontrol custom_1=shoko is_complete=true -o path | while read path; do ln -s "/data/media$path" /shoko; done
rtcontrol custom_1=shoko-movie is_complete=true -o path | while read path; do ln -s "/data/media$path" /shoko_movie; done

# change label to tagged
rtcontrol --custom 1=tagged custom_1=shoko is_complete=true
# change label to tagged
rtcontrol --custom 1=tagged custom_1=shoko-movie is_complete=true
