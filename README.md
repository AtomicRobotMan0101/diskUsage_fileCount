Linux lacks a single GNU tool to provide **disk usage** and a **file count** for each directory.

`du` provides usage and `find` provides counts, but how to get them BOTH at the same time? .... Gah!

**WHAT IT DOES**

**Example 1**

```
    ┬─[atomicrobot@lounge:~]
    ╰─>$ diskusage.sh 1
    Disk Usage File Count Directory
    ---------- ---------- ---------
    367G       169643     /home/atomicrobot
    65M        1852       /home/atomicrobot/temp
    26M        1892       /home/atomicrobot/.nx
    4.0K       0          /home/atomicrobot/.gconf
    100K       3          /home/atomicrobot/.pki
    4.0K       0          /home/atomicrobot/.themes
    68K        5          /home/atomicrobot/.ssh
    20K        1          /home/atomicrobot/.dbus
    1.1G       13542      /home/atomicrobot/.config
    472K       0          /home/atomicrobot/.terminal_output
    20K        1          /home/atomicrobot/intellij-chatgpt
    6.6G       60318      /home/atomicrobot/.cache
    656K       18         /home/atomicrobot/.java
    90M        93         /home/atomicrobot/.financials-extension
    200K       13         /home/atomicrobot/.clamtk
    8.0K       0          /home/atomicrobot/.nv
    65G        36         /home/atomicrobot/.docker
    36K        1          /home/atomicrobot/Calibre Library
    1.2M       96         /home/atomicrobot/.gnupg
    102M       20         /home/atomicrobot/Desktop
    4.0K       0          /home/atomicrobot/.icons
    7.3G       145        /home/atomicrobot/Music
    16K        1          /home/atomicrobot/.qt
    53M        1919       /home/atomicrobot/.vscode-os
```

**Example 2**
Using sudo so we can plunge into the admin guts
```
    ┬─[atomicrobot@lounge:~/apps]
    ╰─>$ sudo ./diskusage.sh /etc 2
    Disk Usage File Count Directory
    ---------- ---------- ---------
    19M        2696       /etc
    8.0K       1          /etc/mdadm
    12K        2          /etc/bash_completion.d
    36K        8          /etc/sysctl.d
    16K        3          /etc/rsyslog.d
    56K        13         /etc/modprobe.d
    64K        9          /etc/skel
    40K        4          /etc/skel/.config
    8.0K       1          /etc/sasl2
    20K        3          /etc/timeshift
    8.0K       1          /etc/timeshift/restore-hooks.d
    8.0K       1          /etc/ipp-usb
    12K        2          /etc/insserv.conf.d
    36K        6          /etc/ghostscript
    8.0K       1          /etc/ghostscript/fontmap.d
    24K        5          /etc/ghostscript/cidfmap.d
    8.0K       1          /etc/gnome-app-install
    8.0K       1          /etc/openni2
    68K        3          /etc/initramfs-tools
    4.0K       0          /etc/initramfs-tools/hooks
    4.0K       0          /etc/initramfs-tools/conf.d
    44K        0          /etc/initramfs-tools/scripts

```




**Example 3**
Using script 2 to output in a slightly different way
```
    ┬─[atomicrobot@lounge:~]
    ╰─>$ diskusage2.sh  1
    /home/atomicrobot
    367G - 169645

    /home/atomicrobot/temp
    65M - 1852

    /home/atomicrobot/.nx
    26M - 1892

    /home/atomicrobot/.gconf
    4.0K - 0

    /home/atomicrobot/.pki
    100K - 3

    /home/atomicrobot/.themes
    4.0K - 0

    /home/atomicrobot/.ssh
    68K - 5

    /home/atomicrobot/.dbus
    20K - 1

    /home/atomicrobot/.config
    1.1G - 13542

    /home/atomicrobot/.terminal_output
    472K - 0

    /home/atomicrobot/intellij-chatgpt
    20K - 1
```

**HOW TO USE** 

- Run this from the terminal
-  Put this in your $PATH so it may run from anywhere
 - Use `sudo` for where permissions are denied for root accessed files/directories

 **IMPORTANT!**
 
 This script will NOT count soft-mounted, nor hard-mounted links
 
 It is designed to capture what is ON THE DEVICE upon which it is run
 
 One may specify a mount in `/mnt/foo`

 **USAGE**
 
 - It takes one, or two, paramaters
     - First is depth you wish to count
         - i.e. 1,2,3... one deep, or N-deep
     - Second is the directory to target, then the count

 The script will assume the currect directory unless an alternative is
 specified

**EXAMPLES**
- ./diskusage.sh 1
-  ./diskusage.sh 5
-  ./diskusage.sh /etc 1
-  ./diskusage.sh ~ 3  # /home/foo
-  ./diskusage.sh /mnt/NAS/Movies/ 3

 There are TWO scripts, each outputs content in a particular way
 that I found useful for the task at hand

 Please feel free to modify this to suit you own needs, or offer
 suggestions, improvements or pull requests for updates :)

.
.
.

**MORE EXPLANATION OF THE PROBLEM**

- `du` (Disk Usage):
    - `du -sh /path/to/directory`: Shows the disk usage of a directory.
    - `du -h --max-depth=1 /path/to/directory`: Shows the disk usage of a directory and its subdirectories up to a specified depth.

- `find` (File Counting):
    - `find /path/to/directory -type f | wc -l`: Counts the number of regular files in a directory.
    - `find /path/to/directory -type l -exec test ! -e /mnt/{} \; | wc -l`: Counts the number of symlinks excluding those pointing to /mnt.

- `ncdu` (NCurses Disk Usage):
    - `ncdu /path/to/directory`: Provides a visual representation of disk usage and can be used to explore directories interactively.

- `tree` (Directory Tree Listing):
    - `tree -L 1 /path/to/directory`: Lists directories and files up to a specified depth, but doesn't show disk usage or file counts by default.
    - `tree -h /path/to/directory`: Shows a hierarchical view of directories with file sizes.

This script attempts to combine these tools in a neat, fast, GNU-ish like manner.
