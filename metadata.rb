name             'aws_elk'
maintainer       'Galo Andrade'
maintainer_email 'gandrade@eastridge.com'
license          'All rights reserved'
description      'Installs/Configures the ELK stack for EWS'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.3.3'

# Cookbooks from SuperMarket
#depends 'htpasswd', '~> 0.2.4'
depends 'java', '~> 1.48'
depends 'chef-client'
depends 'elasticsearch', '~> 3.1.0'
