<?php

$id = strval($_GET['id']);
$q = strval($_GET['q']);
$t = strval($_GET['t']);

$con = mysqli_connect('localhost','veritas','v45W34eD787','veritas');
if (!$con)
  {
  die('Could not connect: ' . mysqli_error($con));
  }
mysqli_select_db($con,"veritas");
$sql="insert into reponses_spatiales (id_part, num_quest, type_rep) values ('".$id."','".$q."','".$t."')";

if (!mysqli_query($con,$sql))
  {
  die('Error: ' . mysqli_error($con));
  }
echo "1 record added";

mysqli_close($con);
?>