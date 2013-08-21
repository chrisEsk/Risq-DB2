#!/bin/bash

CREDENTIALS="risq@localhost/risq2";

run_sql() {
    echo "running $1...";

    sqlplus $CREDENTIALS <<EOF
    @$1;
    exit;
EOF
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

for i in $(ls datos_prueba/*.sql | sort -n); do
    run_sql "$i";
done;

echo "done!";
