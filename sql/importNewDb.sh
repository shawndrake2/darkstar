
# =============================================================================
# =============================================================================
# ======                                                              =========
# ====== This script will drop the DB specified, then create the DB   =========
# ====== specified, and then load all .sql tables from its run dir to =========
# ====== the DB.                                                      =========
# ======                                                              =========
# ====== File needs to be run from within the same folder with all    =========
# ====== the .sql files. By default it WILL DROP the standard dspdb   =========
# ====== DB, losing all accounts and characters. If this is not       =========
# ====== desired, then use the updateDb.sh script instead             =========
# ======                                                              =========
# ====== Update MySQL credentials.                                    =========
# ======                                                              =========
# =============================================================================
# =============================================================================

USER="ffxids"
PASS="ffxids"
HOST="localhost"
DBNAME="dspdb"

printf "Drop existing Database dspdb\n"
mysql -u ${USER} -p${PASS} -h ${HOST} -e "DROP DATABASE IF EXISTS ${DBNAME}"

printf "Creating Database dspdb\n"
mysql -u ${USER} -p${PASS} -h ${HOST} -e "CREATE DATABASE IF NOT EXISTS ${DBNAME}"

printf "Loading dspdb tables into the database"
for FILE in *.sql
do
    printf "Importing: ${FILE}\n"
    mysql -u ${USER} -p${PASS} -h ${HOST} ${DBNAME} < ${FILE}
done

printf "Finished!\n"