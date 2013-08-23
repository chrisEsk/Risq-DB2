#!/bin/bash

CREDENTIALS="risq@localhost/risq2";
PARAM="$1";
OUT="";
N='
';

run_sql() {
    if [[ "$PARAM" == "gen" ]]; then
        OUT="$OUT""start $1;$N";
    else
        echo "running $1...";

        sqlplus $CREDENTIALS <<EOF
        @$1;
        exit;
EOF
    fi
}

run_sql "risqbd-sql.sql";

for i in $(ls initial_inserts/*.sql | sort -n); do
    run_sql "$i";
done;

for i in $(ls functions/*.sql | sort -n); do
    run_sql "$i";
done;

for i in $(ls procedures/*.sql | sort -n); do
    run_sql "$i";
done;

#for i in $(ls datos_prueba/*.sql | sort -n); do
#    run_sql "$i";
#done;

if [[ "$PARAM" == "gen" ]]; then
    echo "$OUT" > "start.sql";
fi;

echo "done!";
