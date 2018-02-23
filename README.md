Verium Miner Files
==================
Files and scripts related to my ODROID XU4 Verium Miner setup. Most of these
were hacked together for my little 25-ish machine setup. Not necessarily the
most well engineered solutions, but they work for me (mostly).

If there are issues, let me know.

The following 2 scripts are for monitoring verium miners across a LAN.
monitor.py is the display. I run it on my LAN controller so it has no problems
finding each worker. miner-apid.py is a python script that should run on your
worker AFTER starting all cpuminer instances (a line to have it run in the
background in rc.local should suffice). The monitor will pickup workers after
reboots as well.

### Monitor and Miner API Scripts (Require Python 3.x, libzmq, and pyzmq)
 * [Miner API Daemon](https://github.com/bezeredi/verium-mining-files/blob/master/miner-apid.py)
 * [LAN Miner Monitor](https://github.com/bezeredi/verium-mining-files/blob/master/monitor.py)

![alt text](https://github.com/bezeredi/verium-mining-files/blob/master/vrm-mining-rig-monitor.png "CLI Monitor Preview")

### Pretty Verium Unicode Logon Picture
 * [Verium Unicode Picture](https://github.com/bezeredi/verium-mining-files/blob/master/issue.verium)

![alt text](https://github.com/bezeredi/verium-mining-files/blob/master/issue.verium.png "Unicode Verium Logo")

### Logfile Scripts
 * [Get Miner Status](https://github.com/bezeredi/verium-mining-files/blob/master/is-mining.sh)
 * [Get Miner Hashrate](https://github.com/bezeredi/verium-mining-files/blob/master/hashrate.sh)
 * [Get Miner Shares](https://github.com/bezeredi/verium-mining-files/blob/master/shares.sh)
 * [CPU Temp](https://github.com/bezeredi/verium-mining-files/blob/master/cputemp.sh)

### LAN Logfile Scripts
 * [LAN Miner Hashrate](https://github.com/bezeredi/verium-mining-files/blob/master/chashrate.sh)
 * [LAN Miner Shares](https://github.com/bezeredi/verium-mining-files/blob/master/cshares.sh)
 * [LAN Ping](https://github.com/bezeredi/verium-mining-files/blob/master/cping.sh)
 * [Machine CPU Temps](https://github.com/bezeredi/verium-mining-files/blob/master/ctemp.sh)
 * [Machine Uptimes](https://github.com/bezeredi/verium-mining-files/blob/master/cuptime.sh)

License
-------
Free to use, just give credit where it's due.
