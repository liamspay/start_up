#!/bin/bash

gnome-terminal --tab --title='tab2'  --command="/bin/bash -c '. ~/Desktop/vinh/start/start_up/start_chrome.sh';bash" --tab --title='tab5'  --command="/bin/bash -c 'watch -tcn 10 .~/Desktop/vinh/start/start_up/count_bank_error.sh';bash" --tab --title='tab3' --command="/bin/bash -c 'ssh -L5000:localhost:3000 urhub-ss-dev-monitoring-ec2-0; top';bash" --tab --title='tab4' --command="/bin/bash -c 'ssh -L4000:localhost:3000 urhub-uat-monitoring-ec2-0; top';bash" --tab --title='tab4' --command="/bin/bash -c 'ssh -L3000:localhost:3000 urhub-prod-monitoring-ec2-0; top';bash";
