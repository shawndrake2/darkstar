<?php

# =============================================================================
# =============================================================================
# ======                                                              =========
# ====== This script will update the DB specified, ignoring character =========
# ====== related tables.                                              =========
# ======                                                              =========
# ====== File needs to be run from within the \dsp\sql folder (same   =========
# ====== folder with all the .sql files. Please edit as needed.       =========
# ======                                                              =========
# =============================================================================
# =============================================================================

$user = 'ffxids';
$pass = 'ffxids';
$host = 'localhost';
$dbname = 'dspdb';

$ignoreTables = [
	'auction_house.sql',
	'chars.sql',
	'accounts.sql',
	'accounts_banned.sql',
	'char_effects.sql',
	'char_equip.sql',
	'char_exp.sql',
	'char_inventory.sql',
	'char_jobs.sql',
	'char_look.sql',
	'char_pet.sql',
	'char_pet_name.sql',
	'char_points.sql',
	'char_profile.sql',
	'char_skills.sql',
	'char_spells.sql',
	'char_stats.sql',
	'char_storage.sql',
	'char_vars.sql',
	'char_weapon_skill_points.sql',
	'chars.sql',
	'conquest_system.sql',
	'delivery_box.sql',
	'linkshells.sql'
];

try {
    $db = new mysqli($host, $user, $pass, $dbname);

    $sqlScripts = scandir(__DIR__);
    echo "Loading ${dbname} tables into the database" . PHP_EOL;
    $ignoreLines = ['--', '/*', '//', ''];
    foreach ($sqlScripts as $file) {
        if (preg_match('/\.sql$/', $file) && !in_array($file, $ignoreTables) {
            echo "Importing ${file}" . PHP_EOL;
            $sqlContents = file($file);
            $sql = '';
            $isBlockComment = false;
            foreach ($sqlContents as $row) {
                $firstChars = substr(trim($row), 0, 2);
                $lastChars = substr(trim($row), -3);
                // Check for block comment open
                if ($firstChars === '/*') {
                    // check if it's a one-liner first
                    if (strpos($lastChars, '*/') === false) {
                        $isBlockComment = true;
                    }
                }
                // If not a block comment, keep parsing
                if (!$isBlockComment && !in_array($firstChars, $ignoreLines)) {
                        $sql .= $row;
                }
                // Finally, if we're in a block comment, check for comment close
                if ($isBlockComment && ($firstChars === '*/' || strpos($lastChars, '*/'))) {
                    $isBlockComment = false;
                }
            }
            if (!$db->multi_query($sql)) {
                throw new Exception("${file} failed to import; Halting execution.");
            }
            // flush multi_queries
            while ($db->next_result())
            {
                if (!$db->more_results()) break;
            }
        }
    }
    echo "All Done! Database updated!" . PHP_EOL;
} catch (Throwable $throwable) {
    echo $throwable->getMessage();
}
