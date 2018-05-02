`cpuminer` Config Files
=====================
These JSON files are the config files that I use for my ODROID XU4 Verium
miners. Each config is built for a special version of the `cpuminer` that
uses 3way threads with hugepages, 1way threads with hugepages, and 1way threads
without hugepages. That means I'm running 3 `cpuminer` instances. I have
observed that my workers submit more accepted shares this way than they do with
a single or dual `cpuminer` setup.
