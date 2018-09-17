
# =============================================================================
# =============================================================================
# ======                                                              =========
# ====== This script will update the DB specified ignoring character =========
# ====== related tables.                                              =========
# ======                                                              =========
# ====== File needs to be run from within the \dsp\sql folder (same   =========
# ====== folder with all the .sql files. Please edit as needed.       =========
# ======                                                              =========
# =============================================================================
# =============================================================================

USER="ffxids"
PASS="ffxids"
HOST="localhost"
DBNAME="dspdb"

IGNORE_TABLES=(
"auction_house.sql"
"accounts.sql"
"accounts_banned.sql"
"char_blacklist.sql"
"char_effects.sql"
"char_equip.sql"
"char_exp.sql"
"char_inventory.sql"
"char_jobs.sql"
"char_look.sql"
"char_merit.sql"
"char_pet.sql"
"char_pet_name.sql"
"char_points.sql"
"char_profile.sql"
"char_recast.sql"
"char_skills.sql"
"char_spells.sql"
"char_stats.sql"
"char_storage.sql"
"char_style.sql"
"char_vars.sql"
"char_weapon_skill_points.sql"
"chars.sql"
"conquest_system.sql"
"delivery_box.sql"
"linkshells.sql"
"zzz_ryken.sql"
)

for FILE in *.sql
do
    import=1
    for IGNORE in "${IGNORE_TABLES[@]}"
    do
        if [ "${FILE}" == "${IGNORE}" ]; then
            import=0
        fi
    done
    if [[ ${import} == 1 ]]; then
        printf "Importing: ${FILE}\n"
        mysql -u ${USER} -p${PASS} -h ${HOST} ${DBNAME} < ${FILE}
    fi
done

