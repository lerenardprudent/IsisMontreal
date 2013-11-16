<?php

$up = strval($_GET['up']);
$id = strval($_GET['id']);
$q = strval($_GET['q']);
$t = strval($_GET['t']);
$lat = doubleval($_GET['lat']);
$lon = doubleval($_GET['lon']);

$table = 'rep_spat';

if (strcmp($up,"mo") == 0)  // Insert new
{
	$db_update_func = 'do_mysql_modify';
}
else
{
	$db_update_func = 'do_mysql_insert';
}

$db_con = connect();
echo "Looking for ".$db_update_func."\n";
if (!function_exists($db_update_func)) {
	die('Update function not found!' . mysqli_error($db_con));
}
$db_update_func($db_con,$table,$id,$q,$t,$lat,$lon);
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

function do_mysql_insert($db,$tbl,$id,$q,$t,$lat,$lon) {
	echo "\nInserting into ".$tbl."...\n";
	mysqli_select_db($db,"veritas");
	echo "ID: ".$id;
	$sql="insert into ".$tbl." (id_part, num_quest, type_rep, geom_point) values ('".$id."','".$q."','".$t."',GeomFromText('point(".$lat." ".$lon.")'))";
	echo "Sending ".$sql."\n";
	if (!mysqli_query($db,$sql))
	  {
	  die('Error: ' . mysqli_error($db));
	  }
	echo "1 record added";
}

function do_mysql_modify($db,$tbl,$id,$q,$t,$lat,$lon) {
	mysqli_select_db($db,"veritas");
	$sql="update ".$tbl." set num_quest='".$q."',type_rep='".$t."',geom_point=GeomFromText('point(".$lat." ".$lon.")') where id_part='".$id."'";
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