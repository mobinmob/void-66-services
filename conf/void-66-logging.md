# Logging in 66

## Basic concept

s6 uses the logging concept pioneered by daemontools. That means that for every service there can be a log service that will save to a file everything that the service sends to its stdout. With stderr typically being redirected to stdout, that means that everything the service sends there also gets logged.
s6 setup typically use s6-log for the log service. The basic consept result to a simple and robust system, that does not have the single-point-of-failure issue associated with typical syslog.

## 66

66 enables a log-service using s6-log for every **longrun** and **classic** service by default. It also saves the output of oneshots to log file.

The output of *66-inservice(1)* contains the last lines of the service log among the other information. The folowing is the full output for a gitea service:

```

Name                  : gitea
Version               : 0.0.3
In tree               : default
Status                : enabled, up (pid 1306) 25916 seconds
Type                  : classic
Description           : gitea daemon
Source                : /usr/share/66/service/gitea
Live                  : /run/66/scandir/0/gitea
Dependencies          : gitea-log
External dependencies : None
Optional dependencies : None
Start script          :  
                        	cd /var/lib/gitea
                        	execl-cmdline -s { gitea web --config ${config_file} } 
Stop script           : None
Environment source    : /etc/66/conf/gitea/0.0.3
Environment file      : environment variables from: /etc/66/conf/gitea/0.0.3/.gitea
                        USER=_gitea
                        HOME=/var/lib/gitea
                        GITEA_WORK_DIR=var/lib/gitea
                        config_file=!/etc/gitea.conf
 

                        environment variables from: /etc/66/conf/gitea/0.0.3/gitea
                        USER=_gitea
                        HOME=/var/lib/gitea
                        GITEA_WORK_DIR=var/lib/gitea
                        config_file=!/etc/gitea.conf

Log name              : gitea-log
Log destination       : /var/log/66/gitea
Log file              : 
2022-02-12 10:42:07.189430414  2022/02/12 10:42:07 ...les/storage/local.go:47:NewLocalStorage() [I] Creating new Local Storage at /var/lib/gitea/data/avatars
2022-02-12 10:42:07.189445675  2022/02/12 10:42:07 ...s/storage/storage.go:183:initRepoAvatars() [I] Initialising Repository Avatar storage with type: local
2022-02-12 10:42:07.189490440  2022/02/12 10:42:07 ...les/storage/local.go:47:NewLocalStorage() [I] Creating new Local Storage at var/lib/gitea/data/repo-avatars
2022-02-12 10:42:07.189494270  2022/02/12 10:42:07 ...s/storage/storage.go:177:initLFS() [I] Initialising LFS storage with type: local
2022-02-12 10:42:07.189508626  2022/02/12 10:42:07 ...les/storage/local.go:47:NewLocalStorage() [I] Creating new Local Storage at /var/lib/gitea/lfs
2022-02-12 10:42:07.189719944  2022/02/12 10:42:07 ...s/storage/storage.go:189:initRepoArchives() [I] Initialising Repository Archive storage with type: local
2022-02-12 10:42:07.189731323  2022/02/12 10:42:07 ...les/storage/local.go:47:NewLocalStorage() [I] Creating new Local Storage at var/lib/gitea/data/repo-archive
2022-02-12 10:42:07.249947373  2022/02/12 10:42:07 routers/init.go:93:GlobalInit() [I] SQLite3 Supported
2022-02-12 10:42:07.249963680  2022/02/12 10:42:07 routers/common/db.go:20:InitDBEngine() [I] Beginning ORM engine initialization.
2022-02-12 10:42:07.250006895  2022/02/12 10:42:07 routers/common/db.go:27:InitDBEngine() [I] ORM engine initialization attempt #1/10...
2022-02-12 10:42:07.250432797  2022/02/12 10:42:07 ...om/urfave/cli/app.go:524:HandleAction() [I] PING DATABASE sqlite3
2022-02-12 10:42:07.297377401  2022/02/12 10:42:07 ...om/urfave/cli/app.go:524:HandleAction() [W] Table email_address Column lower_email db nullable is true, struct nullable is false
2022-02-12 10:42:07.308878529  2022/02/12 10:42:07 routers/init.go:98:GlobalInit() [I] ORM engine initialization successful!
2022-02-12 10:42:07.325954771  2022/02/12 10:42:07 ...xer/stats/indexer.go:38:populateRepoIndexer() [I] Populating the repo stats indexer with existing repositories
2022-02-12 10:42:07.326068371  2022/02/12 10:42:07 ...er/issues/indexer.go:142:func2() [I] PID 1306: Initializing Issue Indexer: bleve
2022-02-12 10:42:07.333095438  2022/02/12 10:42:07 ...er/issues/indexer.go:221:func3() [I] Issue Indexer Initialization took 7.608012ms
2022-02-12 10:42:07.619159674  2022/02/12 10:42:07 cmd/web.go:196:listen() [I] Listen: http://0.0.0.0:3000
2022-02-12 10:42:07.619173907  2022/02/12 10:42:07 cmd/web.go:200:listen() [I] AppURL(ROOT_URL): http://localhost:3000/
2022-02-12 10:42:07.619177735  2022/02/12 10:42:07 cmd/web.go:203:listen() [I] LFS server enabled
2022-02-12 10:42:07.619241365  2022/02/12 10:42:07 ...s/graceful/server.go:62:NewServer() [I] Starting new Web server: tcp:0.0.0.0:3000 on PID: 1306

```

In the output above, 66 inform the user about the logging directory:

```
Log destination       : /var/log/66/gitea
```
In this directory on can fing a file name current, that holds the current log, and - sometines- other files, that hold older logs, as s6-log is configures to auto-rotate the log file.

The log directory in void linux is always /var/log/66/servicename.
Most service frontends that have log information are configured to use this native log solution.

## Disabling the log service.

The logger can be disabled if the user does not want log information directed to the log file.
That is configured in the *@options* key in the *[main]* section of the service frontend file by adding **!log**. If the key is absent that means adding the line:

```
@options = ( !log )
```

## Using syslog in addition to the per-service logger

There are scenarions in which having a central logging mechanism in desired. To do that without losing the per-service log - and the nice, complete output of 66-service-,  all that is needed is a syslog daemon that can take input from log files and proper configuration for said daemon.

*rsyslog* has this ability with the [imfile module](https://rsyslog.readthedocs.io/en/latest/configuration/modules/imfile.html).

To enable logging to syslog for our gitea example we can add the following to the rsyslog conf file:

```
module(load="imfile" PollingInterval="10")

input(type="imfile"
      File="/var/log/66/gitea/current"
      Tag="gitea-66")

```
After we start the rsyslogd service, the log messages from gitea will appear in the rsyslogd managed log files in addition to the 66-inservice output.
This is of course a very barebones rsyslogs configuration example, please consult the rsyslog documentation for more.
