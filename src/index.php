<?php
require_once "../vendor/autoload.php";
use Monolog\Handler\BufferHandler;
use Monolog\Logger;
use NewRelic\Monolog\Enricher\{Handler, Processor};

$log = new Logger('log');
$log->pushProcessor(new Processor);
$log->pushHandler(new BufferHandler(new Handler));
?>
<html>
<h1>hello world</h1>
<div>
<?php

  echo "now is the time";
  error_log("Trying out on error log message.", 0);
  $log->info('Hello, world via Monolog!');
  $log->error("Trying out on error log message via Monolog.");

  $testvalue = 1 / 0;
  echo $testvalue;

?>
</div>
</html>