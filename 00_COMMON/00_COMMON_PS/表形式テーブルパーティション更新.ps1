param (
	#接続先のサーバ名
	[string] $serverName = "dbi1aw011",
	#接続先のインスタンス名
	[string] $insName = "default",
	#祖h理対象のデータベース名
	[string] $dbName
)

Import-Module SQLserver

#cd sqlserver:\sqlas\サーバ名\インスタンス名\databases\データベース名\Tables
cd sqlserver:\sqlas\$serverName\$insName\databases\$dbName\Tables

#ディメンションは差分更新
ls | Get-Item | Where Name -Like 'D*' | Invoke-ProcessTable -RefreshType Automatic

#ファクトは完全更新
ls | Get-Item | Where Name -Like 'F*' | Invoke-ProcessTable -RefreshType Full

#戻り値0を返す
Return 0