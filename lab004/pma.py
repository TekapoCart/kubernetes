"""Create pma template with the back-end and front-end templates."""


def GenerateConfig(context):
  """Generate configuration."""

  backend = context.env['deployment'] + '-backend'
  frontend = context.env['deployment'] + '-frontend'
  firewall = context.env['deployment'] + '-application-fw'
  application_port = 80
  mysql_port = 3306
  resources = [{
      'name': backend,
      'type': 'container_vm.py',
      'properties': {
          'zone': context.properties['zone'],
          'dockerImage': 'mariadb',
          'dockerEnv': {
              'MYSQL_ALLOW_EMPTY_PASSWORD': 'yes'
          },
          # 'dockerImage': 'gcr.io/deployment-manager-examples/mysql',
          'containerImage': 'family/cos-stable',
          'port': mysql_port
      }
  }, {
      'name': frontend,
      'type': 'frontend.py',
      'properties': {
          'zone': context.properties['zone'],
          'dockerImage': 'phpmyadmin/phpmyadmin',
          'port': application_port,
          # Define the variables that are exposed to container as env variables.
          'dockerEnv': {
              'PMA_PORT': mysql_port,
              'PMA_HOST': '$(ref.' + backend + '.networkInterfaces[0].networkIP)'
          },
          # If left out will default to 1
          'size': 2,
          # If left out will default to 1
          'maxSize': {{MAX_SIZE}}
      }
  }, {
      'name': firewall,
      'type': 'compute.v1.firewall',
      'properties': {
          'allowed': [{
              'IPProtocol': 'TCP',
              'ports': [application_port]
          }],
          'sourceRanges': ['0.0.0.0/0']
      }
  }]
  return {'resources': resources}