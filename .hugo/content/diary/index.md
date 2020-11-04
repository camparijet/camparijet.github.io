+++
title = "Diary"
draft = false
+++

<div class="ox-hugo-toc toc">
<div></div>

<div class="heading">Table of Contents</div>

- [introduce wifi direct between PC and Android under sshfs](#introduce-wifi-direct-between-pc-and-android-under-sshfs)
    - [structure](#structure)
    - [speed test between phone and PC](#speed-test-between-phone-and-pc)
    - [sshfs brutual shutdown cause other problems](#sshfs-brutual-shutdown-cause-other-problems)
        - [behavior difference between wifi and usb](#behavior-difference-between-wifi-and-usb)
        - [tramp on termux](#tramp-on-termux):hotfix:
- [How to authorize my Baby to public Service in Germany](#how-to-authorize-my-baby-to-public-service-in-germany)
- [How to prepare Parent's birth proof (Familienbuch)](#how-to-prepare-parent-s-birth-proof--familienbuch)
    - [When Your family in your original country can help](#when-your-family-in-your-original-country-can-help)
    - [When You do by yourself](#when-you-do-by-yourself)
- [Job title shows mindset, not position](#job-title-shows-mindset-not-position):tech:
- [Initial test](#initial-test):emacs:org:
- [design pattern of pthread](#design-pattern-of-pthread)

</div>
<!--endtoc-->



## introduce wifi direct between PC and Android under sshfs {#introduce-wifi-direct-between-pc-and-android-under-sshfs}

Usually I write memo in files in the storage under my Android phone.

Previously I use usb-tethering between Android phone and PC connection.


### structure {#structure}

mount sshfs + wifi direct

{{< figure src="/ox-hugo/wifi_direct_sshfs_nexus5x.png" >}}


### speed test between phone and PC {#speed-test-between-phone-and-pc}

wifi direct

```text
% iperf3 -c 192.168.49.1
Connecting to host 192.168.49.1, port 5201
[  4] local 192.168.49.80 port 42588 connected to 192.168.49.1 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec  6.64 MBytes  55.7 Mbits/sec    0    243 KBytes
[  4]   1.00-2.00   sec  5.90 MBytes  49.5 Mbits/sec    0    355 KBytes
[  4]   2.00-3.00   sec  5.53 MBytes  46.4 Mbits/sec    0    395 KBytes
[  4]   3.00-4.00   sec  5.53 MBytes  46.4 Mbits/sec    0    485 KBytes
[  4]   4.00-5.00   sec  3.04 MBytes  25.5 Mbits/sec    1    485 KBytes
[  4]   5.00-6.00   sec  5.41 MBytes  45.4 Mbits/sec    0    509 KBytes
[  4]   6.00-7.00   sec  5.72 MBytes  48.0 Mbits/sec    0    536 KBytes
[  4]   7.00-8.00   sec  5.97 MBytes  50.0 Mbits/sec    0    591 KBytes
[  4]   8.00-9.00   sec  6.23 MBytes  52.3 Mbits/sec    0    653 KBytes
[  4]   9.00-10.00  sec  6.25 MBytes  52.4 Mbits/sec    0    724 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-10.00  sec  56.2 MBytes  47.2 Mbits/sec    1             sender
[  4]   0.00-10.00  sec  52.6 MBytes  44.2 Mbits/sec                  receiver
```

wired

```text
% iperf3 -c 192.168.42.129
Connecting to host 192.168.42.129, port 5201
[  4] local 192.168.42.143 port 38882 connected to 192.168.42.129 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec  18.9 MBytes   159 Mbits/sec    0    187 KBytes
[  4]   1.00-2.00   sec  19.2 MBytes   161 Mbits/sec    0    215 KBytes
[  4]   2.00-3.00   sec  19.3 MBytes   162 Mbits/sec    0    245 KBytes
[  4]   3.00-4.00   sec  19.1 MBytes   160 Mbits/sec    0    245 KBytes
[  4]   4.00-5.00   sec  19.3 MBytes   162 Mbits/sec    0    266 KBytes
[  4]   5.00-6.00   sec  19.3 MBytes   162 Mbits/sec    0    266 KBytes
[  4]   6.00-7.00   sec  19.2 MBytes   161 Mbits/sec    0    266 KBytes
[  4]   7.00-8.00   sec  19.4 MBytes   163 Mbits/sec    0    266 KBytes
[  4]   8.00-9.00   sec  19.0 MBytes   159 Mbits/sec    0    430 KBytes
[  4]   9.00-10.00  sec  19.2 MBytes   161 Mbits/sec    0    430 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-10.00  sec   192 MBytes   161 Mbits/sec    0             sender
[  4]   0.00-10.00  sec   191 MBytes   161 Mbits/sec                  receiver
```

So the wifi direct environment is 3~4 times slower than the wired one


### sshfs brutual shutdown cause other problems {#sshfs-brutual-shutdown-cause-other-problems}

-   when you modify file which is mounted via sshfs, your editor may get stuck

-   shutdown gracefully when wifi is away

-   enable verbose log


#### behavior difference between wifi and usb {#behavior-difference-between-wifi-and-usb}

-   emacs goes hang over wifi-direct while it doesn't over USB
-   using fuse in debugging mode shows over USB also failed, it seems because background may handle signal correctly for disconnection
-   fuse logs
    -   [wifi](research/wifi-direct/wifi_direct_brutual_disconnect_sshfs.log)
    -   [usb](research/wifi-direct/usb_brutual_disconnect_sshfs.log)


#### tramp on termux {#tramp-on-termux}

Some people say "tramp in emacs avoid this problem"

So I tried tramp after setting the following additionally.

```elisp
(add-to-list 'tramp-remote-path "/data/data/com.termux/files/usr/bin" t)
(add-to-list 'tramp-remote-path "/data/data/com.termux/files/usr/bin/applets" t)
```

I feel this was so slow not reliable enough unfortunately.


## How to authorize my Baby to public Service in Germany {#how-to-authorize-my-baby-to-public-service-in-germany}

For instance, it requires your Baby's identificatin number of German citizen and Residence Permission to access following service

-   Kindergeld
-   Elterngeld
-   KITA Guteschein

Following shows actual flow from birth event to finish all conditinos.

It seems to take 3 months at least, if your original country is Japan. And bottle-neck is creating "Family Registration" record in Japan. That sounds a little bit funny.

{{< figure src="/ox-hugo/en_sequence_baby_authorization.png" >}}

Questions are

-   Do we need official translator of Geburtsurkunde for Birth Certificate?
-   Don't we have any easier way to finish Baby's Citizen Registration without Passport?


## How to prepare Parent's birth proof (Familienbuch) {#how-to-prepare-parent-s-birth-proof--familienbuch}


### When Your family in your original country can help {#when-your-family-in-your-original-country-can-help}

{{< figure src="/ox-hugo/en_sequence_with_family.png" >}}


### When You do by yourself {#when-you-do-by-yourself}

{{< figure src="/ox-hugo/en_sequence_self.png" >}}


## Job title shows mindset, not position {#job-title-shows-mindset-not-position}

<span class="timestamp-wrapper"><span class="timestamp">[2018-03-14 Wed]</span></span>

Just for note. Job title is of course a position in the company, but one colleague tells a junior in his team that since companies have various structure, same name positions have various roles. So It is mind-set that is made common among the company by title.


## Initial test {#initial-test}

<span class="timestamp-wrapper"><span class="timestamp">[2018-03-11 Sun]</span></span>

Today is 7-year-anniversary for Fukushima Earthquake.
 Berlin weather radically changes today, now 16 cel degree. It's crazy because it was -10 cel degree.

Try to start using <https://github.com/fniessen/org-html-themes>.


## design pattern of pthread {#design-pattern-of-pthread}

-   worker - watcher model
    -   normal case
        -   how watcher detects worker finishes
    -   late case
        -   how to kill the thread from watcher to worker

{{< figure src="/ox-hugo/pthread_design.png" >}}
