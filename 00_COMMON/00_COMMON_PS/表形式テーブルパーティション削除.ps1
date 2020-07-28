param (
    #パーティションで一番小さいパーティション名を指定する
    [string] $minPartName,
    #対象のテーブル名を指定する
    [string] $tableName,
	#接続先のサーバ名
	[string] $serverName = "dbi1aw011",
	#接続先のインスタンス名
	[string] $insName = "default",
	#祖h理対象のデータベース名
	[string] $dbName
)

function removePartition ($partition)
{
	echo $partition
	$xmla = "{
		`"delete`": {
			 `"object`": {
				`"database`": `"$dbName`",
				`"table`": `"$tableName`",
				`"partition`": `"$partition`"
			}
		}
	}"

	echo $xmla
	Invoke-ASCmd -Server $serverName\$insName  -Database $dbName -Query $xmla
}


Import-Module SQLserver

#cd sqlserver:\sqlas\サーバ名\インスタンス名\databases\データベース名\Tables
cd sqlserver:\sqlas\$serverName\$insName\databases\$dbName\Tables\$tableName\Partitions

if ($minPartName.length -le 0) {
    echo "残したい最小のパーティション名を指定してください"
} else {

    #それよりも前のパーティションは削除する
    $pats = ls | get-item | where Name -lt $minPartName
	$pats | %{ removePartition($_.Name);}
}

#戻り値0をちゃんと返す
Return 0