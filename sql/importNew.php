<?php

# =============================================================================
# =============================================================================
# ======                                                              =========
# ====== THis script will drop the DB specificed, then create the DB  =========
# ====== specified, and then load all .sql tables from its run dir to =========
# ====== the the DB.                                                  =========
# ======                                                              =========
# ====== File needs to be run from within the \dsp\sql folder (same   =========
# ====== folder with all the .sql files. Please edit as needed. By    =========
# ====== default it WILL DROP the standard dspdb DB, losing all      =========
# ====== accounts and characters. If this is not desired, then update =========
# ====== the file to load the new DB into a new DB name.              =========
# ======                                                              =========
# ====== Update -p with MySQL password. If you password is 'foo',     =========
# ====== then change '-pMYSQLPASS' to '-pfoo' (3 places).             =========
# ======                                                              =========
# ====== If you want to use a different database name, change 'dspdb' =========
# ====== with a database name of your choosing.                       =========
# ======                                                              =========
# =============================================================================
# =============================================================================

$user = 'ffxids';
$pass = 'ffxids';
$host = 'localhost';
$dbname = 'dspdb';

try {
    $db = new mysqli($host, $user, $pass);

    // Remove the db if it already exists
    echo "Dropping database ${dbname} (if exists) " . PHP_EOL;
    if (!$db->query("DROP DATABASE IF EXISTS ${dbname}")) {
        throw new Exception("Database drop failed");
    }
    echo "Creating database ${dbname}" . PHP_EOL;
    if (!$db->query("CREATE DATABASE ${dbname}")) {
        throw new Exception("Database creation failed");
    }

    // Use the new db we created
    $db->select_db($dbname);

    $sqlScripts = scandir(__DIR__);
    echo "Loading ${dbname} tables into the database" . PHP_EOL;
    $ignoreLines = ['--', '/*', '//', ''];
    foreach ($sqlScripts as $file) {
        if (preg_match('/\.sql$/', $file)) {
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
    echo "All Done! Enjoy!" . PHP_EOL;
} catch (Throwable $throwable) {
    echo $throwable->getMessage();
}
