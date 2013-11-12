<?php header("Content-type: text/html; charset=utf-8");

	$database = "saut";		//check for server prefix
	$username="webuser";
	$password = "WxcMeW4BL1";

	@mysql_connect($localhost, $username, $password);
	@mysql_query("SET NAMES 'utf8'");
	@mysql_select_db($database);

	$querySQL = "select author from apps where id='13'";
	$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
	if($result)
	{
		while ($row = mysql_fetch_array($result))
		{
			$retv = $row[author];
		}
		echo $retv;
	}
	else
	{
		echo "ERROR";
	}
	@mysql_close();	
?>	
		
