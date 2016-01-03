gehirn-ddns
===========

## これはなに
最悪な DDNS スクリプト。cron で5分ごとに回すと良い

## Usage
```
gddns.rb -c [PATH]
```

## Config
```
{
  "token": "API_TOKEN",
  "secret": "API_SECRET",
  "domain": "example.com",
  "record": "subdomain.example.com."
}
```
Note the trailing `.` in the `record` field.
