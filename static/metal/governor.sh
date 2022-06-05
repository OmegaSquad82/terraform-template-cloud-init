#!/usr/bin/env bash
set -euo pipefail
SCR="${0##*/}"
TARGET=${SCR%.sh}

IFS=" " read -r -a FRQS <<<"$(cpufreq-info -l)"
echo "Got lower ${FRQS[0]:?lower frequency not set} Hz and upper ${FRQS[1]:?upper frequency not set} Hz limits."

for ((i = 0; i < $(nproc); i++)); do
    echo "cpufreq-set -c $i -d ${FRQS[0]} -u ${FRQS[1]} -g $TARGET"
    cpufreq-set -c "$i" -d "${FRQS[0]}" -u "${FRQS[1]}" -g "$TARGET"
done
