<?php

header("Access-Control-Allow-Origin: *"); // Allow requests from any origin (no>
header("Access-Control-Allow-Headers: X-API-Key"); 

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    header("Access-Control-Allow-Origin: *");
    header("Access-Control-Allow-Headers: X-API-Key");
    exit();
}

error_reporting(E_ALL);
ini_set('display_errors', 1);

$log_file = '/var/www/html/logs/debug.log';

// Log function
function log_message($message) {
    global $log_file;
    file_put_contents($log_file, date('Y-m-d H:i:s') . " - " . $message . "\n", FILE_APPEND);
}

// List of valid API keys
$valid_api_keys = array(
    "device1" => "########",
);

// Function to validate API key
function validate_api_key($key) {
    global $valid_api_keys;
    return in_array($key, $valid_api_keys);
}

// Get API key from headers
$headers = getallheaders();
if (!isset($headers['X-API-Key'])) {
    http_response_code(401);
    log_message(json_encode($headers));
    exit();
}

$api_key = $headers['X-API-Key'];
if (!validate_api_key($api_key)) {
    http_response_code(401);
    log_message("Access denied. Invalid API key.");
    exit();
}

// Validate and execute script
$script = $_GET['script'];
$allowed_scripts = array('wake_server.sh', 'server_sleep.sh');

if (in_array($script, $allowed_scripts)) {
    $output = shell_exec("/scripts/" . escapeshellcmd($script));
    log_message("script: " . $script);
    log_message("output: " . $output);
} else {
    http_response_code(400);
    log_message("Invalid script.");
}
?>

