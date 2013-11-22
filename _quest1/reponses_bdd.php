<?php

$up = strval($_GET['up']);
$id = strval($_GET['id']);
$q = strval($_GET['q']);
$t = strval($_GET['t']);
$s = strval($_GET['s']); // Texte supplémentaire
$geo = strval($_GET['geo']);
$GLOBALS['colsep'] = '$';

$resp_table = 'reponses_spatiales';
$home_table = 'domiciles';
$table = $resp_table;

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
else {
	die("Could not recognise update type");
}

$db_con = connect();
//echo "Looking for ".$db_update_func."\n";
if (!function_exists($db_update_func)) {
	die('Update function not found!' . mysqli_error($db_con));
}
$db_update_func($db_con,$table,$id,$q,$t,$s,$geo);
disconnect($db_con);

function connect()
{
	$con = mysqli_connect('localhost','veritas','v45W34eD787','veritas');
	if (!$con)
	{
	  die('Could not connect: ' . mysqli_error($con));
	}
	return $con;
}

function createNewTable($table_name)
{
	//CREATE TABLE `rep_spat` (`id_part` varchar(8) collate utf8_unicode_ci NOT NULL,`num_quest` varchar(3) collate utf8_unicode_ci NOT NULL,`type_rep` varchar(8) collate utf8_unicode_ci NOT NULL,`nom` varchar(80) collate utf8_unicode_ci NOT NULL, `geom_point` point default NULL,`geom_poly` polygon default NULL,PRIMARY KEY  (`id_part`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tableau pour les réponses spatiales au questionnaire ISIS'
}

function do_mysql_insert_or_modify($db,$tbl,$id,$q,$t,$s,$g) {
	if (!do_mysql_insert($db,$tbl,$id,$q,$t,$s,$g))
		do_mysql_modify($db,$tbl,$id,$q,$t,$s,$g);
}

function do_mysql_insert_or_modify_poly($db,$tbl,$id,$q,$t,$s,$g) {
	if (!do_mysql_insert_poly($db,$tbl,$id,$q,$t,$s,$g))
		do_mysql_modify_poly($db,$tbl,$id,$q,$t,$s,$g);
}

function do_mysql_insert($db,$tbl,$id,$q,$t,$s,$g) {
	echo "\nInserting into ".$tbl."...\n";
	mysqli_select_db($db,"veritas");
	echo "ID: ".$id;
	$sql="insert into ".$tbl." (id_part, num_quest, type_rep, geom_point, addr_text) values ('".$id."','".$q."','".$t."',GeomFromText('".$g."'),'".$s."')";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($db,$sql))
	  {
	  echo('Error: ' . mysqli_error($db));
	  return false;
	  }
	echo "1 record added";
	return true;
}

function do_mysql_insert_poly($db,$tbl,$id,$q,$t,$s,$g) {
	echo "\nInserting into ".$tbl."...\n";
	mysqli_select_db($db,"veritas");
	$sql="insert into ".$tbl." (id_part, num_quest, type_rep, addr_text, geom_poly) values ('".$id."','".$q."','".$t."','".$s."',GeomFromText('".$g."'))";
	echo "INSERTING: ".$sql;
	if (!mysqli_query($db,$sql)) {
	  echo('Error: ' . mysqli_error($db));
	  return false;
	}
	echo "1 record added";
	return true;
}

function do_mysql_modify_poly($db,$tbl,$id,$q,$t,$s,$g) {
	mysqli_select_db($db,"veritas");
	$sql="update ".$tbl." set addr_text='".$s."',geom_poly=GeomFromText('".$g."') where id_part='".$id."' and num_quest='".$q."'";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($db,$sql))
	  {
	  die('Error: ' . mysqli_error($db));
	  }
	echo "1 poly record modified";
}

function do_mysql_delete_poly($db,$tbl,$id,$q,$t,$s,$g) {
	mysqli_select_db($db,"veritas");
	$sql="delete from ".$tbl." where id_part='".$id."' and num_quest='".$q."'";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($db,$sql))
	  {
	  die('Error: ' . mysqli_error($db));
	  }
	echo "1 poly record deleted";
}

function do_mysql_home_lookup($db,$tbl,$id,$q,$t,$s,$g) {
	mysqli_select_db($db,"veritas");
	$sql="SELECT astext(geom) as geom, addr_texte, eligible FROM ".$tbl." WHERE id_part = '".$id."'";
	$result = mysqli_query($db,$sql);
	while($row = mysqli_fetch_array($result))
	{
		echo $row['geom'].$GLOBALS['colsep'].$row['addr_texte'].$GLOBALS['colsep'].$row['eligible'];
    }
}

function do_mysql_home_insert_or_modify($db,$tbl,$id,$q,$t,$s,$g) {
	if (!do_mysql_home_insert($db,$tbl,$id,$q,$t,$s,$g))
		do_mysql_home_modify($db,$tbl,$id,$q,$t,$s,$g);
}

function do_mysql_home_insert($db,$tbl,$id,$q,$t,$s,$g) {
	mysqli_select_db($db,"veritas");
	$isElig = strtoupper($t);
	$sql="insert into ".$tbl." (id_part, geom, addr_texte, eligible) values ('".$id."',GeomFromText('".$g."'),'".$s."',".$t.")";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($db,$sql))
	  {
	  echo('Error: ' . mysqli_error($db));
	  return false;
	  }
	echo "1 home record added";
	return true;
}

function do_mysql_home_modify($db,$tbl,$id,$q,$t,$s,$g) {
	mysqli_select_db($db,"veritas");
	$sql="update ".$tbl." set geom=GeomFromText('".$g."'),addr_texte='".$s."',eligible=".$t." where id_part='".$id."'";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($db,$sql))
	  {
	  die('Error: ' . mysqli_error($db));
	  }
	echo "1 home record modified";
}

function do_mysql_resp_lookup($db,$tbl,$id,$q,$t,$s,$g) {
	mysqli_select_db($db,"veritas");
	$sql="SELECT astext(geom_point) as geom_point, astext(geom_poly) as geom_poly, addr_text FROM ".$tbl." WHERE id_part = '".$id."' and num_quest='".$q."'";
	$result = mysqli_query($db,$sql);

	while($row = mysqli_fetch_array($result))
	{
		echo $row['geom_point'].$GLOBALS['colsep'].$row['geom_poly'].$GLOBALS['colsep'].$row['addr_text'];
		return;
    }
	return "";
}

function do_mysql_modify($db,$tbl,$id,$q,$t,$s,$g) {
	mysqli_select_db($db,"veritas");
	$sql="update ".$tbl." set type_rep='".$t."',addr_text='".$s."',geom_point=GeomFromText('".$g."') where id_part='".$id."' and num_quest='".$q."'";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($db,$sql))
	  {
	  die('Error: ' . mysqli_error($db));
	  }
	echo "1 record modified";
}

function disconnect($db)
{
	mysqli_close($db);
}
?>