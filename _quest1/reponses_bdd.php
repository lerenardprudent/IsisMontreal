<?php

$up = strval($_GET['up']);
$id = strval($_GET['id']);
$q = strval($_GET['q']);
$t = strval($_GET['t']);
$s = strval($_GET['s']); // Texte supplémentaire
$lat = doubleval($_GET['lat']);
$lon = doubleval($_GET['lon']);

$resp_table = 'rep_spat';
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
	$db_update_func = 'do_mysql_home_insert';
	$table = $home_table;
}
else if (strcmp($up,"rl") == 0)  // Response lookup
{
	$db_update_func = 'do_mysql_resp_lookup';
}
else if (strcmp($up,"in") == 0)  // Response lookup
{
	$db_update_func = 'do_mysql_insert_or_modify';
}
else {
	die("Could not recognise update type");
}

$db_con = connect();
//echo "Looking for ".$db_update_func."\n";
if (!function_exists($db_update_func)) {
	die('Update function not found!' . mysqli_error($db_con));
}
$db_update_func($db_con,$table,$id,$q,$t,$lat,$lon,$s);
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

function do_mysql_insert_or_modify($db,$tbl,$id,$q,$t,$lat,$lon,$s) {
	if (!do_mysql_insert($db,$tbl,$id,$q,$t,$lat,$lon,$s))
		do_mysql_modify($db,$tbl,$id,$q,$t,$lat,$lon,$s);
}

function do_mysql_insert($db,$tbl,$id,$q,$t,$lat,$lon,$s) {
	echo "\nInserting into ".$tbl."...\n";
	mysqli_select_db($db,"veritas");
	echo "ID: ".$id;
	$sql="insert into ".$tbl." (id_part, num_quest, type_rep, geom_point, addr_point) values ('".$id."','".$q."','".$t."',GeomFromText('point(".$lat." ".$lon.")'),'".$s."')";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($db,$sql))
	  {
	  echo('Error: ' . mysqli_error($db));
	  return false;
	  }
	echo "1 record added";
	return true;
}

function do_mysql_home_lookup($db,$tbl,$id,$q,$t,$lat,$lon,$s) {
	mysqli_select_db($db,"veritas");
	$sql="SELECT astext(geom) as geom FROM ".$tbl." WHERE id_part = '".$id."'";
	$result = mysqli_query($db,$sql);

	while($row = mysqli_fetch_array($result))
	{
		echo $row['geom'];
    }
}

function do_mysql_home_insert($db,$tbl,$id,$q,$t,$lat,$lon,$s) {
	echo "\nInserting into ".$tbl."...\n";
	mysqli_select_db($db,"veritas");
	echo "ID: ".$id;
	$sql="insert into ".$tbl." (id_part, geom, addr_texte) values ('".$id."',GeomFromText('point(".$lat." ".$lon.")'),'".$s."')";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($db,$sql))
	  {
	  die('Error: ' . mysqli_error($db));
	  }
	echo "1 record added";
}

function do_mysql_resp_lookup($db,$tbl,$id,$q,$t,$lat,$lon,$s) {
	mysqli_select_db($db,"veritas");
	$sql="SELECT astext(geom_point) as geom FROM ".$tbl." WHERE id_part = '".$id."' and num_quest='".$q."'";
	$result = mysqli_query($db,$sql);

	while($row = mysqli_fetch_array($result))
	{
		echo $row['geom'];
		return;
    }
	return "";
}

function do_mysql_modify($db,$tbl,$id,$q,$t,$lat,$lon,$s) {
	mysqli_select_db($db,"veritas");
	$sql="update ".$tbl." set num_quest='".$q."',type_rep='".$t."',addr_point='".$s."',geom_point=GeomFromText('point(".$lat." ".$lon.")') where id_part='".$id."'";
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