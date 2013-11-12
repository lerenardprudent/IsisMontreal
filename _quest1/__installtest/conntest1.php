<?php header("Content-type: text/html; charset=utf-8");

	$database = "beanz";		//check for server prefix
	$username="webuser";
	$password = "WxcMeW4BL1";

	@mysql_connect($localhost, $username, $password);
	@mysql_query("SET NAMES 'utf8'");
	@mysql_select_db($database);

	$querySQL = "select id, fname, lname from users where idusr='AUT001'";
	$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
	if($result)
	{
		while ($row = mysql_fetch_array($result))
		{
			$retv = $row[id]. "¦" .$row[fname]. "¦" .$row[lname];
		}
		echo $retv;
	}
	else
	{
		echo "ERROR";
	}
	@mysql_close();	
?>	
		
