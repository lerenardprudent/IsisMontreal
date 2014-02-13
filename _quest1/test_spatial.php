<?php ini_set("memory_limit","1024M");

function validate_test($conn, $conf)
{
  set_time_limit(9000*60);
  $pointFile = "ext/test_rmr462.txt";
  
  $numTestsPerBlock = 10;
  $startAt = 0;
  $finishAt = 499;
  $numRuns = 1;
  
  $table = getAttrValOrDie($conf, 'tbl');
  $inel = getAttrValOrDie($conf, 'ineligible');
  $file = fopen($pointFile, "r");
  $lines = array();
  $first_line = true;
  while (($line = fgets($file)) !== false) {
    if (!$first_line)
      array_push($lines, $line);
    $first_line = false;
  }
  fclose($file);
  
  header('Content-Type: text/html; charset=UTF-8');
  for ( $run = 1; $run <= $numRuns; $run++ ) {
    for ( $j = $startAt; $j < $finishAt; $j += $numTestsPerBlock) {
      testBlock($conn,$lines,$table,$inel,$j, $numTestsPerBlock);
      //echo "MEM: ".memory_get_usage()."<br>";
    }
  }
}

function testBlock($conn,$lines,$table,$inel,$startAt,$numTests)
{
  $totalMatches = 0;
  $nonMatches = array();
  echo "*** Testing ".$startAt."-".($startAt+$numTests-1)."... ***<br>";
  $debug = "";
  for ($i = $startAt; $i-$startAt < $numTests; $i++ ) {
    $testRes = testLine($conn,$lines[$i],$table,$inel);
    $ok = $testRes[0];
    $debug = $testRes[4];
    if ($ok) { 
      ++$totalMatches;
    }
    else {
      array_push($nonMatches, $i);
      echo $debug;
      echo $i.": ".$lines[$i]." --- SHOULD BE ".($testRes[1] ? "1 " : "0 ")."(".$testRes[2].") FUNC RETURNED ".($testRes[3] ? "1" : "0")."<br>";
      break;
    }
  }
      
  echo "Matches: ".$totalMatches." / ".$numTests."<br>";
  
  foreach( $nonMatches as $x) {
    $tokens = explode(",", $lines[$x]);
    $lon = $tokens[1];
    $lat = $tokens[2];
    $inRMR = $tokens[3][0] == '1';
    $revalidRes = validate_coords($conn,$lat,$lon,$table,$inel);
    $isElig = $revalidRes;
    echo $revalidRes[1];
    die($lines[$x].($isElig ? "1 " : "0 ")."<br>");
  }
  echo "<br>";
}

function testLine($conn,$line,$table,$inel)
{
  $tokens = explode(",", $line);
  $lon = $tokens[1];
  $lat = $tokens[2];
  $inRMR = ($tokens[3][0] == '1');
  $validateRes = validate_coords($conn,$lat,$lon,$table,$inel,false);
  $isElig = $validateRes[0];
  $debug = $validateRes[1];
  return array( $isElig == $inRMR, $inRMR, "'".$tokens[3][0]."'", $isElig, $debug );
}
?>