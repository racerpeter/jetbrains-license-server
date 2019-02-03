#!/bin/bash

echo "Configuring license server..."
$BASE_DIR/bin/license-server.sh configure --port 8080

if [ -n "$LICENSE_SERVER_HOST" ]; then
  echo "Using hostname $LICENSE_SERVER_HOST..."
  $BASE_DIR/bin/license-server.sh configure --host $LICENSE_SERVER_HOST --jetty.virtualHosts.names=$LICENSE_SERVER_HOST
fi
if [[ -n "$LICENSE_SERVER_SMTP_SERVER"  &&  -n "$LICENSE_SERVER_STATS_RECIPIENTS" ]]; then
    smtp_port=${LICENSE_SERVER_SMTP_PORT:-25}
    echo "Enabling Stats via SMTP at $LICENSE_SERVER_SMTP_SERVER:$smtp_port..."
    $BASE_DIR/bin/license-server.sh configure --smtp.server $LICENSE_SERVER_SMTP_SERVER --smtp.server.port $smtp_port

    echo "Stats recipient(s): $LICENSE_SERVER_STATS_RECIPIENTS..."
    $BASE_DIR/bin/license-server.sh configure --stats.recipients $LICENSE_SERVER_STATS_RECIPIENTS

    if [[ -n "$LICENSE_SERVER_SMTP_USERNAME"  &&  -n "$LICENSE_SERVER_SMTP_PASSWORD" ]]; then
        echo "Using SMTP username $LICENSE_SERVER_SMTP_USERNAME with password..."
        $BASE_DIR/bin/license-server.sh configure --smtp.server.username $LICENSE_SERVER_SMTP_USERNAME
        $BASE_DIR/bin/license-server.sh configure --smtp.server.password $LICENSE_SERVER_SMTP_PASSWORD
      fi

    if [ -n "$LICENSE_SERVER_STATS_FROM" ]; then
      echo "Using hostname $LICENSE_SERVER_STATS_FROM..."
      $BASE_DIR/bin/license-server.sh configure --stats.from $LICENSE_SERVER_STATS_FROM
    fi
  fi

license_restrictions=${LICENSE_SERVER_USER_RESTRICTIONS-/root/access-config.json}
if [ -s $license_restrictions ]; then
  echo "Enabling user restrictions loaded from $license_restrictions..."
  $BASE_DIR/bin/license-server.sh configure --access.config=file:$license_restrictions
fi

if [ -n "$LICENSE_SERVER_STATS_TOKEN" ]; then
  echo "Enabling stats via API at /$LICENSE_SERVER_STATS_TOKEN..."
  $BASE_DIR/bin/license-server.sh configure --reporting.token $LICENSE_SERVER_STATS_TOKEN
fi

echo "Starting license server..."
$BASE_DIR/bin/license-server.sh run

echo "exited $0"
