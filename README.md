# aws_elk Cookbook

Cookbook to quickly deploy an all-in-one ELK instance

## Requirements

Depends on Java, elasticsearch, and chef-client cookbooks all sourced from Chef SuperMarket. Only tested on CentOS in an AWS environment.


### Platforms

- CentOS 7

### Chef

- Chef 12.0 or later

### Cookbooks

- `java` - aws_elk installs java since it is needed before installing ELK
- `elasticsearch` - aws_elk uses this cookbook to make installing/configuration easier to do. Why re-invent the wheel?
- `chef-client` - periodically run chef-client to fix config drift

## Attributes

### aws_elk::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['aws_elk']['kibana']['server_host']</tt></td>
    <td>String</td>
    <td>Specifies the address to which Kibana will bind to. In this case localhost since nginx is used to protect kibana</td>
    <td><tt>localhost</tt></td>
  </tr>
    <tr>
    <td><tt>['aws_elk']['kibana']['nginx']['server_name']</tt></td>
    <td>String</td>
    <td>Specifies the address to which nginx will bind to. This is usually hostname of server</td>
    <td><tt>servername</tt></td>
  </tr>
</table>

## Usage

### aws_elk::default

Just include `aws_elk` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[aws_elk]"
  ]
}
```

### aws_elk::kibana

Requires databag on chef server to set nginx password and keep recipe clean. 
Format of databag ['passwords']['kibana']['nginx_pw']

## License and Authors

Authors: Galo

