# 其他

## xserver
Edit `/etc/ssh/sshd_config` and make sure you have `X11Forwarding yes` 

```shell
sudo apt-get install dbus-x11
```

参考：
- [What's the easiest way to run GUI apps on Windows Subsystem for Linux as of 2018?](https://askubuntu.com/questions/993225/whats-the-easiest-way-to-run-gui-apps-on-windows-subsystem-for-linux-as-of-2018)
- [LIBDBUSMENU-GLIB-WARNING](https://askubuntu.com/questions/1005623/libdbusmenu-glib-warning-unable-to-get-session-bus-failed-to-execute-child)  
Unable to get session bus: Failed to execute child process “dbus-launch” (No such file or directory) while x-forwarding