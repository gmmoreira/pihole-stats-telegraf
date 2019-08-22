# [Pi-hole][pi-hole] stats for [Telegraf][telegraf]
This repository contains a small bash script that extract a few metrics from Pi-hole admin api. Combined with telegraf, those metrics can be outputed to a database like InfluxDB and visualized in graphing tools like Grafana.

![grafana dashboard](/screenshot.png)

## Requirements
- [Pi-hole][pi-hole]: It has only been tested in Pi-hole v4.0. It may require some adjustments in another versions
- `curl` for requesting the api
- `jq` to parse, extract and build the JSON for telegraf
- `sed` to perform transfromations on datatypes to make them compatible with influxdb

## Installation
- Copy the file `piholestats.sh` to `/usr/local/bin`. Make sure it has execution permission (may require `chmod +x`).
- Edit the file `/etc/telegraf/telegraf.conf` and paste the content below:
- (optional) import the example `grafana.json` dashboard

```
# PiHole monitoring
[[inputs.exec]]
    commands = ["/usr/local/bin/piholestats.sh"]
    timeout = "10s"
    data_format = "json"
    name_suffix = "_pihole"
```

Measurement name is `exec_pihole`.

[telegraf]: (https://github.com/influxdata/telegraf)
[pi-hole]: (https://github.com/pi-hole/pi-hole)
