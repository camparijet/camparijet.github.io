+++
title = "design pattern of pthread"
date = 2018-03-11T21:55:00+01:00
draft = false
+++

-   worker - watcher model
    -   normal case
        -   how watcher detects worker finishes
    -   late case
        -   how to kill the thread from watcher to worker

{{< figure src="/ox-hugo/pthread_design.png" >}}
