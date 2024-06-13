acl localclients {
  127.0.0.1/32;
  10.0.0.0/8;
  172.16.0.0/12;
  192.168.0.0/16;
};

acl secondaries {
};

options {
  listen-on { any; };
  directory "/bind/etc";
  recursion yes;
  allow-query { localclients; };
  querylog no;
  allow-notify { none; };
  forwarders { 1.1.1.1; 1.0.0.1; };
  version "0.0";
  auth-nxdomain no;
  max-cache-size 0;
  dnssec-validation auto;
};

statistics-channels {
  inet 0.0.0.0 port 8053;
};

server ::/0 { bogus yes; };

logging {
  category default { default_syslog; default_debug; default_log; };
  category config { default_syslog; default_debug; default_log; };
  category dispatch { default_syslog; default_debug; default_log; };
  category network { default_syslog; default_debug; default_log; };
  category general { default_syslog; default_debug; default_log; };
};

zone "." {
  type hint;
  file "root.db";
};

zone "localhost" {
  type primary;
  file "localhost.db";
  notify no;
};

zone "0.0.127.in-addr.arpa" {
  type primary;
  file "localhost.rev";
  notify no;
};

zone "example.com" {
  type primary;
  file "example.com.db";
  notify no;
};

zone "catalog.example.com" {
  type primary;
  file "catalog.example.com";
  notify yes;
  allow-transfer { ; };
};

