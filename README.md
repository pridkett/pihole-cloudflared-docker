Pi-Hole, Cloudflared, NextDNS, Unifi, and Docker
================================================

Patrick Wagstrom &lt;patrick@wagstrom.net&gt;

March 2020

Overview
--------

This repository contains my docker compose configuration for running DNS on my
local network. In particular it does the following:

1. Creates a private network inside of docker compose called `pihole_net`.
2. Spins up a container with cloudflared running on port 5054 and IP address
   172.20.0.2
3. Spins up a container running NextDNS with IP address 172.20.0.3
4. Spins up a container running dnsmasq for Unifi Dream Machine Pro on 172.20.0.4
5. Spins up a container with Pi-Hole and IP address 172.20.0.10

Once this is spun up for the first time, you'll need to go into the PiHole
settings and set DNS to be `172.20.0.2#5054` and remove any other IP addresses.
At this point you should now have Pi-Hole set up so it is blocking ads and also
ensuring you have security by transparently sending standard DNS record
requests via DNS over HTTPS to Cloudflare's server at 1.1.1.1. This brings you
not only faster browsing, but also protects you from snooping on your behavior
by your ISP and Google. You'll need to decide for yourself if sending all your
queries to Cloudflare is worth the security risk.

Configuration
-------------

You'll want to create a file called `.env` that contains environment variables
for your containers. The following are keys that are accepted:

* **`WEBPASSWORD`** - The administrative password for your Pi-Hole instance.
* **`DNS1`** - Primary DNS host for Cloudflared. Defaults to `1.1.1.1`
* **`DNS2`** - Secondary DNS host for Cloudflared. Defaults to `1.0.0.1`
