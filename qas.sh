tc qdisc add dev wlp2s0 root handle 1: htb default 900

tc class add dev wlp2s0 parent 1: classid 1:1 htb rate 100Mbit

tc filter add dev wlp2s0 parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:1 action drop

tc class add dev wlp2s0 parent 1:1 classid 1:10 htb rate 40Mbit

tc class add dev wlp2s0 parent 1:1 classid 1:20 htb rate 20Mbit

tc class add dev wlp2s0 parent 1:1 classid 1:30 htb rate 20Mbit

tc class add dev wlp2s0 parent 1:1 classid 1:40 htb rate 20Mbit

tc filter add dev wlp2s0 protocol ip parent 1:1 prio 1 u32 match ip protocol 6 0xff match ip dst 172.17.0.3/16 match ip sport 22 0xffff flowid 1:30 action drop

tc filter add dev wlp2s0 protocol ip parent 1:1 prio 1 u32 match ip dst 172.17.0.2/16 match ip protocol 17 0xff flowid 1:20

tc filter add dev wlp2s0 protocol ip parent 1:1 prio 1 u32 match ip dst 172.17.0.1/16 flowid 1:10

tc filter add dev wlp2s0 protocol ip parent 1:1 prio 2 u32 match ip dst 172.17.0.2/16 flowid 1:20

tc filter add dev wlp2s0 protocol ip parent 1:1 prio 2 u32 match ip dst 172.17.0.3/16 flowid 1:30

tc filter add dev wlp2s0 protocol ip parent 1:1 prio 1 u32 match ip dst 172.17.0.4/16 flowid 1:40
