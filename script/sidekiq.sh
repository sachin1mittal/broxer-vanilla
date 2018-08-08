#!/usr/bin/env bash

SIDEKIQ_LOG_FILE=log/sidekiq.log
SIDEKIQ_CONFIGS=config/sidekiq
SIDEKIQ_PIDS=tmp/pids/sidekiq
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# check if sidekiq process is running
sidekiq_is_running() {
  if [ -d $SIDEKIQ_PIDS ]; then
    files=($SIDEKIQ_PIDS/*.pid)
    if [ ${#files[@]} -gt 0 ]; then
      return 0
    fi
  fi

  return 1
}

case "$1" in
  start)
    echo "Starting sidekiq..."
    mkdir -p $SIDEKIQ_PIDS
    for config in $SIDEKIQ_CONFIGS/*.yml; do
      config_name=${config/$SIDEKIQ_CONFIGS/}
      echo $config_name
      pid_file="$SIDEKIQ_PIDS${config_name/yml/pid}"
      bundle exec sidekiq -d -P $pid_file -L $SIDEKIQ_LOG_FILE -C $config
    done

    echo "done"
    ;;

  stop)
    echo "Stopping sidekiq..."
    for pid in $SIDEKIQ_PIDS/*.pid; do
      bundle exec sidekiqctl stop $pid 5
      rm -rf $pid
    done

    echo "done"
    ;;

  restart)
    echo "Restarting sidekiq..."
    if sidekiq_is_running ; then
      ${DIR}/sidekiq.sh stop
    fi
    ${DIR}/sidekiq.sh start
    ;;

  *)
    echo "Usage: script/sidekiq.sh {start|stop|restart}" >&2
    ;;
esac
