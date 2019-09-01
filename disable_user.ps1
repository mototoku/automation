
# 無効化するアカウントの一覧ファイル
$csvfile = "user_list.csv"
# ADServer上から取得した姓名を格納するファイル
$outfile = "user_list_in_ADServer.csv"
# 無効化後のアカウントの状態を格納するファイル
$status = "user_status_in_ADServer.csv"

# 配列に無効化するアカウントの一覧を格納
$inputcsv = ipcsv $csvfile

# 無効化するアカウントの姓名を取得してCSVファイルに格納
foreach ($u in $inputcsv) {

    $fullname = (Get-ADUser -Identity $($u.Name)).surname
    $fullname += " "
    $fullname += (Get-ADUser -Identity $($u.Name)).givenname
    echo ${fullname} | Out-File -encoding UTF8 -Append ${outfile}

}

# アカウントを無効化して、無効化後のアカウントの状態をCSVファイルに格納
foreach ($u in $inputcsv) {

  echo "delete..."
  echo $($u.Name)

  Set-ADUser -Identity $($u.Name) -Enabled $false

  (Get-ADUser -Identity $($u.Name)).enabled | Out-File -encoding UTF8 -Append ${status.csv}

}
