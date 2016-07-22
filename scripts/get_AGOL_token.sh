#!/bin/bash
cred=$(< ~/config/credentials/AGOL_cred.txt)
curl --data "$cred" \
  https://maps.formationclient.com/apollo/tokens/gettoken \
  > ~/analysis/Rowens/data/AGOL_token.txt
