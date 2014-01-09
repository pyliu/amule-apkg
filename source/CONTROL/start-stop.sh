#!/bin/sh -e
export HOST_ARCH=$(uname -m)
export NAME="aMule"

export PKG_PATH=/usr/local/AppCentral/amule
export PKG_DAEMON="$PKG_PATH/bin/amuled"

export USER=admin
export GROUP=administrators
export STOP_TIMEOUT=10

# Default options for daemon
export OPTIONS="--full-daemon --config-dir=$PKG_PATH/etc/amule"

#export PATH="${PATH:+$PKG_PATH:}/sbin"
export PATH="${PKG_PATH}/bin:$PATH"
export LD_LIBRARY_PATH="$PKG_PATH/lib"

. /lib/lsb/init-functions

start_daemon () {
    start-stop-daemon --start \
    --chuid ${USER}:${GROUP} \
    --exec $PKG_DAEMON -- $OPTIONS
}

wait_pid () {
    DAEMON=`basename $1`
    TIME=0
    TIMEOUT=$2

    while [ $TIME -lt $TIMEOUT ]; do
        pidof $DAEMON > /dev/null 2>&1
        STATUS=`echo $?`

        if [ $STATUS -eq 1 ]; then
            break 1
        fi

        TIME=$((TIME+1))
        sleep 1
    done
}

case "$1" in
    start)
        echo "Starting $NAME"

        start_daemon
        ;;
    stop)
        echo "Stopping $NAME"

        start-stop-daemon --stop --quiet \
            --exec $PKG_DAEMON --retry $STOP_TIMEOUT \
            --oknodo
        echo -n "Shutting down amuled... "
        killall amuled
        killall amuleweb 

        wait_pid $PKG_DAEMON $STOP_TIMEOUT
        ;;
    reload)
        echo "Reloading $NAME"
        start-stop-daemon --stop --quiet \
            --exec $PKG_DAEMON \
            --oknodo --signal 1
        ;;
    restart|force-reload)
        echo "Restarting $NAME"
        start-stop-daemon --stop --quiet \
            --exec $PKG_DAEMON --retry $STOP_TIMEOUT \
            --oknodo

        wait_pid $PKG_DAEMON $STOP_TIMEOUT

        start_daemon
        ;;
    *)
        echo "Usage: $0 {start|stop|reload|force-reload|restart}"
        exit 2
        ;;
esac

exit 0
