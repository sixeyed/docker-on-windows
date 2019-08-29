# start Grafana and give it time to spin up
Start-Process grafana-server -NoNewWindow 
Start-Sleep 20

# create new user
$auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes('admin:admin'))
Invoke-RestMethod `
 -Method Post `
 -ContentType 'application/json' `
 -Headers @{Authorization="Basic $auth"} `
 -Body '{ "name":"viewer", "email":"viewer@org.com", "login":"viewer",  "password":"readonly" }' `
 -Uri http://localhost:3000/api/admin/users 

# set user's home dashboard     
$auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes('viewer:readonly'))
Invoke-RestMethod `
 -Method Put `
 -ContentType 'application/json' `
 -Headers @{Authorization="Basic $auth"} `
 -Body '{ "homeDashboardId":1 }' `
 -Uri http://localhost:3000/api/user/preferences
