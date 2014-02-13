<?php
$fichierConfig = 'config.json';
$bdloginAttr = 'bd_login';
$bdTblxAttr = 'bd_tableaux';
$hostAttr = 'host';
$userAttr = 'user';
$pwdAttr = 'pwd';
$bdAttr = 'bd';
$dbUpdateUrlField = 'db_update_url_token';
$tblDomicileAttr = 'tbl_domiciles';
$tblReponsesAttr = 'tbl_reponses';
$bdArrondsAttr = 'arronds_spatials';
$ineligAttr = 'ineligible';

try {
	$jsonData = file_get_contents($fichierConfig);
}
catch (Exception $e) {
	die ("Fichier de configuration '".$fichierConfig."' n'existe pas!");
}

$config = json_decode($jsonData);

getAttrValOrDie($config, $bdloginAttr);
$host = getAttrValOrDie($config->$bdloginAttr, $hostAttr);
$user = getAttrValOrDie($config->$bdloginAttr, $userAttr);
$pwd = getAttrValOrDie($config->$bdloginAttr, $pwdAttr);
$db = getAttrValOrDie($config->$bdloginAttr, $bdAttr);
$db_update_url_token = getAttrValOrDie($config, $dbUpdateUrlField);

$sql_conn = connect($host, $db, $user, $pwd);

getAttrValOrDie($config, $bdTblxAttr);
$home_table = getAttrValOrDie($config->$bdTblxAttr, $tblDomicileAttr);
$resp_table = getAttrValOrDie($config->$bdTblxAttr, $tblReponsesAttr);
$table = $resp_table;
$keyId = "cle";
$arron_conf = getAttrValOrDie($config, $bdArrondsAttr);
$key = getAttrValOrDie($arron_conf, $keyId);

$up = strval($_GET[$db_update_url_token]);
if (strcmp($up,"su") == 0) // Setup tables
{
	create_home_addr_table($sql_conn, $home_table);
	create_resp_table($sql_conn, $resp_table);
	return;
}
else if (strcmp($up,"dropall") == 0) // Clean up tables
{
	drop_table($sql_conn, $home_table);
	drop_table($sql_conn, $resp_table);
	return;
}
else if (strcmp($up,$key) == 0)
{
  validate_address($sql_conn, $arron_conf);
	return;
}
else if (strcmp($up,"test") == 0) {
  include_once('test_spatial.php');
  validate_test($sql_conn, $arron_conf);
  return;
}

if (array_key_exists('id', $_GET))
	$id = strval($_GET['id']);
if (array_key_exists('q', $_GET))
	$q = strval($_GET['q']);
else
	$q = "";
if (array_key_exists('t', $_GET))
	$t = strval($_GET['t']);
else
	$t = "";
if (array_key_exists('s', $_GET))	
	$s = strval($_GET['s']); // Texte supplémentaire
else
	$s = "";
if (array_key_exists('geo', $_GET))
	$geo = strval($_GET['geo']);
else
	$geo = "";
	
$GLOBALS['colsep'] = '$';
$GLOBALS['inelig'] = '__PARTICIPANT_EST_INELIGIBLE__';


if (strcmp($up,"hl") == 0)  // Home lookup
{
	$db_update_func = 'do_mysql_home_lookup';
	$table = $home_table;
}
else if (strcmp($up,"mo") == 0)  // Insert new
{
	$db_update_func = 'do_mysql_modify';
}
else if (strcmp($up,"dom") == 0)
{
	$db_update_func = 'do_mysql_home_insert_or_modify';
	$table = $home_table;
}
else if (strcmp($up,"rl") == 0)  // Response lookup
{
	$db_update_func = 'do_mysql_resp_lookup';
}
else if (strcmp($up,"in") == 0)
{
	$db_update_func = 'do_mysql_insert_or_modify';
}
else if (strcmp($up,"ip") == 0)
{
	$db_update_func = 'do_mysql_insert_or_modify_poly';
}
else if (strcmp($up,"dp") == 0)
{
	$db_update_func = 'do_mysql_delete_poly';
}
else if (strcmp($up,"dp") == 0)
{
	$db_update_func = 'do_mysql_delete_poly';
}
else {
	die("Could not recognise update type");
}

//echo "Looking for ".$db_update_func."\n";
if (!function_exists($db_update_func)) {
	die('Update function not found!' . mysqli_error($sql_conn));
}
$db_update_func($sql_conn,$table,$id,$q,$t,$s,$geo);
disconnect($sql_conn);

function connect($host, $db, $user, $pwd)
{
	if ( is_null($pwd) ) {
		$con = mysqli_connect($host, $user);
	}
	else {
		$con = mysqli_connect($host, $user, $pwd);
	}

	// Check connection
	if (mysqli_connect_errno($con))
	{
		echo "Failed to connect to MySQL: " . mysqli_connect_error();
	}
	
	$db_ok = mysqli_select_db($con,$db);
	return $con;
}

function do_mysql_insert_or_modify($conn,$tbl,$id,$q,$t,$s,$g) {
	if (!do_mysql_insert($conn,$tbl,$id,$q,$t,$s,$g))
		do_mysql_modify($conn,$tbl,$id,$q,$t,$s,$g);
}

function do_mysql_insert_or_modify_poly($conn,$tbl,$id,$q,$t,$s,$g) {
	if (!do_mysql_insert_poly($conn,$tbl,$id,$q,$t,$s,$g))
		do_mysql_modify_poly($conn,$tbl,$id,$q,$t,$s,$g);
}

function do_mysql_insert($conn,$tbl,$id,$q,$t,$s,$g) {
	echo "\nInserting into ".$tbl."...\n";
	echo "ID: ".$id;
	$sql="insert into ".$tbl." (id_part, num_quest, type_rep, geom_point, addr_text) values ('".$id."','".$q."','".$t."',GeomFromText('".$g."'),\"".$s."\")";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($conn,$sql))
	  {
	  echo('Error: ' . mysqli_error($conn));
	  return false;
	  }
	echo "1 record added";
	return true;
}

function do_mysql_insert_poly($conn,$tbl,$id,$q,$t,$s,$g) {
	$sql="insert into ".$tbl." (id_part, num_quest, type_rep, addr_text, geom_poly) values ('".$id."','".$q."','".$t."',\"".$s."\",GeomFromText('".$g."'))";
	echo "Sending ".$sql;
	if (!mysqli_query($conn,$sql)) {
	  echo('Error: ' . mysqli_error($conn));
	  return false;
	}
	echo "1 record added";
	return true;
}

function do_mysql_modify_poly($conn,$tbl,$id,$q,$t,$s,$g) {
	$sql="update ".$tbl." set addr_text=\"".$s."\",geom_poly=GeomFromText('".$g."') where id_part='".$id."' and num_quest='".$q."'";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($conn,$sql))
	  {
	  die('Error: ' . mysqli_error($conn));
	  }
	echo "1 poly record modified";
}

function do_mysql_delete_poly($conn,$tbl,$id,$q,$t,$s,$g) {
	$sql="delete from ".$tbl." where id_part='".$id."' and num_quest='".$q."'";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($conn,$sql))
	  {
	  die('Error: ' . mysqli_error($conn));
	  }
	echo "1 poly record deleted";
}

function do_mysql_home_lookup($conn,$tbl,$id,$q,$t,$s,$g) {
	$sql="SELECT astext(geom) as geom, addr_texte, eligible FROM ".$tbl." WHERE id_part = '".$id."'";
	$result = mysqli_query($conn,$sql);
	while($row = mysqli_fetch_array($result))
	{
		echo $row['geom'].$GLOBALS['colsep'].$row['addr_texte'].$GLOBALS['colsep'].$row['eligible'];
    }
}

function do_mysql_home_insert_or_modify($conn,$tbl,$id,$q,$t,$s,$g) {
	if (!do_mysql_home_insert($conn,$tbl,$id,$q,$t,$s,$g))
		do_mysql_home_modify($conn,$tbl,$id,$q,$t,$s,$g);
}

function do_mysql_home_insert($conn,$tbl,$id,$q,$t,$s,$g) {
	$isElig = strtoupper($t);
	$sql="insert into ".$tbl." (id_part, geom, addr_texte, eligible) values ('".$id."',GeomFromText('".$g."'),\"".$s."\",".$t.")";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($conn,$sql))
	  {
	  echo('Error: ' . mysqli_error($conn));
	  return false;
	  }
	echo "1 home record added";
	
	if (!$t) {
		echo $GLOBALS['inelig'];
	}
	
	return true;
}

function do_mysql_home_modify($conn,$tbl,$id,$q,$t,$s,$g) {
	$sql="update ".$tbl." set geom=GeomFromText('".$g."'),addr_texte=\"".$s."\",eligible=".$t." where id_part='".$id."'";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($conn,$sql))
	  {
	  die('Error: ' . mysqli_error($conn));
	  }
	  
	 if (!$t) {
		echo $GLOBALS['inelig'];
	}
	
	echo "1 home record modified";
}

function do_mysql_resp_lookup($conn,$tbl,$id,$q,$t,$s,$g) {
	$sql="SELECT astext(geom_point) as geom_point, astext(geom_poly) as geom_poly, addr_text FROM ".$tbl." WHERE id_part = '".$id."' and num_quest='".$q."'";
	$result = mysqli_query($conn,$sql);

	while($row = mysqli_fetch_array($result))
	{
		echo $row['geom_point'].$GLOBALS['colsep'].$row['geom_poly'].$GLOBALS['colsep'].$row['addr_text'];
		return;
    }
	return "";
}

function do_mysql_modify($conn,$tbl,$id,$q,$t,$s,$g) {
	$sql="update ".$tbl." set type_rep='".$t."',addr_text=\"".$s."\",geom_point=GeomFromText('".$g."') where id_part='".$id."' and num_quest='".$q."'";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($conn,$sql))
	  {
	  die('Error: ' . mysqli_error($conn));
	  }
	echo "1 record modified";
}

function create_home_addr_table($conn, $ht)
{
	$sql = "CREATE TABLE ".$ht." (".
		"id_part varchar(20) collate utf8_unicode_ci NOT NULL,".
		"geom point NOT NULL,".
		"addr_texte varchar(100) collate utf8_unicode_ci NOT NULL,".
		"eligible tinyint(1) NOT NULL,".
		"PRIMARY KEY  (id_part)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($conn,$sql))
	  {
	  die('Error: ' . mysqli_error($conn));
	  }
	echo "Table '".$ht."' created";
}

function create_resp_table($conn, $rt)
{
	$sql = "CREATE TABLE ".$rt." (".
			"id_part varchar(50) collate utf8_unicode_ci NOT NULL,".
			"num_quest varchar(5) collate utf8_unicode_ci NOT NULL,".
			"type_rep varchar(20) collate utf8_unicode_ci NOT NULL,".
			"addr_text varchar(200) collate utf8_unicode_ci NOT NULL,".
			"geom_point point NOT NULL,".
			"geom_poly polygon default NULL,".
			"PRIMARY KEY  (id_part,num_quest)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($conn,$sql))
	  {
	  die('Error: ' . mysqli_error($conn));
	  }
	echo "Table '".$rt."' created";
}

function drop_table($conn, $tbl)
{
	$sql = "DROP TABLE ".$tbl;
	echo "Sending ".$sql."\n";
	if (!mysqli_query($conn,$sql))
	  {
	  die('Error: ' . mysqli_error($conn));
	  }
	echo "Table '".$tbl."' dropped";
}

function disconnect($conn)
{
	mysqli_close($conn);
}

function getAttrValOrDie($config,$attrName)
{
	try {
		return $config->$attrName;
	}
	catch (Exception $e) {
		die("Element de configuration obligatoire manquant: '".$attrName."'");
	}
}

function getUrlArg($arg)
{
	if ( array_key_exists( $arg, $_GET ) )
		return $_GET[$arg];
	die("Param de l'URL manquant: '".$arg."'");
}

function validate_address($conn, $conf)
{
  $latKey = getAttrValOrDie($conf, 'latitude');
  $lonKey = getAttrValOrDie($conf, 'longitude');
  $table = getAttrValOrDie($conf, 'tbl');
	$lat = getUrlArg($latKey);
	$lon = getUrlArg($lonKey);
  $inel = getAttrValOrDie($conf, 'ineligible');
  header('Content-Type: text/html; charset=UTF-8');
  validate_coords($conn,$lat,$lon,$table,$inel);
}

function validate_coords($conn,$lat,$lon,$table,$inel,$echoResult = true)
{
	include_once('polygon.php');
	$point = new vertex($lon,$lat);
	$sql="SELECT sdrnom as nom, GeometryType(shape) as geomtype, ASTEXT(shape) AS geomtext FROM ".$table." where MBRWithin(GeomFromText('POINT(".$lon." ".$lat.")'),shape)";
	$result = mysqli_query($conn,$sql);
  $debug = "Validating ".$lon.", ".$lat."<br>Sent ".$sql."<br>";
  $match = $inel;
  $foundMatch = false;
  
	while($row = mysqli_fetch_array($result))
	{
		$text = $row['geomtext'];
    $munic = $row['nom'];
		if ($row['geomtype'] == 'POLYGON') {
			$polyTexts = array($text);
		}
		else if ($row['geomtype'] == 'MULTIPOLYGON') {
			$text = str_replace(")),((","))|((", substr($text, strlen("MULTIPOLYGON(")));
			$polyTexts = explode("|", $text);
		}
    else die("Unrecognised polygon type");

    $debug .= "Trying ".$munic."<br>";
    
    $testPolyRes = testPolyTexts($polyTexts, $point);
    unset($polyTexts);
    
    $debug .= $testPolyRes[1];
    
    if ($testPolyRes[0]) {
      if ($echoResult)
        $match = utf8_encode($munic);
			$foundMatch = true;
      break;
		}
    
    unset($text);
	}
  if ( $echoResult)
    echo $match;
  $debug .= "Returning ".($foundMatch ? "TRUE" : "FALSE")."<br>";
  return array($foundMatch, $debug);
}

function splitPolyTextIntoLinestrings($polytext)
{
	$openbracketspos = strpos($polytext, "((");
	if ( $openbracketspos !== false ) {
		$closebracketspos = strpos($polytext, "))");
		if ( $closebracketspos !== false ) {
			$text = substr($polytext, $openbracketspos+2, $closebracketspos-$openbracketspos-2);
			return explode("),(", $text);
		}
	}
	return false;
}

function recreatePoly($linestr)
{
	$points = explode(",", $linestr);
	$poly = new polygon2();
  $pointCnt = 0;
	foreach ($points as $point) {
		$x_y = explode(" ", $point);
		$x = floatval($x_y[0]);
		$y = floatval($x_y[1]);
		$poly->addv($x,$y);
    unset($x_y);
    unset($x);
    unset($y);
    $pointCnt++;
    
	}
  unset($points);
	return $poly;
}

function testPolyTexts($polyTexts, $pt)
{
  $debug = "";
	for ( $k = 0; $k < count($polyTexts); $k++ ) {		
    $debug .= ">>> Interrogating polygon ".$k."<br>";
    $polyText = $polyTexts[$k];
    $linestrs = splitPolyTextIntoLinestrings($polyText);
		for ($j = count($linestrs)-1; $j >= 0; $j-- ) {
			$linestr = $linestrs[$j];
			$isExtRing = ( $j == 0 );
      $debug .= "Linestring ".$j."...";
			$inside = testPoly($linestr,$pt);
      if ($inside) {
        $debug .= "Point inside!<br>";
				return array($isExtRing, $debug);
			}
      else {
        $debug .= "Point not inside<br>";
      }
      unset($poly);
		}
    unset($linestrs);
    unset($polyText);
	}
	return array(false, $debug);
}

?>