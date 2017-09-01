#!/sbin/sh
#extracts ramdisk
#finds busbox in /system or sets default location if it cannot be found
#add init.d support if not already supported
#repacks the ramdisk with modifications

OUTFD=$2

ui_print() {
  echo -n -e "ui_print $1\n" > /proc/self/fd/$OUTFD
  echo -n -e "ui_print\n" > /proc/self/fd/$OUTFD
}

mkdir /tmp/ramdisk
cp /tmp/boot.img-ramdisk.gz /tmp/ramdisk/
cd /tmp/ramdisk/
gunzip -c /tmp/ramdisk/boot.img-ramdisk.gz | cpio -i
cd /

#remove cmdline parameters we do not want
#maxcpus=2 in this case, which limits smp activation to the first 2 cpus
echo $(cat /tmp/boot.img-cmdline | sed -e 's/maxcpus=[^ ]\+//')>/tmp/boot.img-cmdline

# Force Permissive on cmdline
#sed -ri 's/ enforcing=[0-1]//g' /tmp/boot.img-cmdline
#sed -ri 's/ androidboot.selinux=permissive|androidboot.selinux=enforcing|androidboot.selinux=disabled//g' /tmp/boot.img-cmdline
#echo $(cat /tmp/boot.img-cmdline) enforcing=0 androidboot.selinux=permissive >/tmp/boot.img-cmdline

#find busybox in /system
bblocation=$(find /system/ -name 'busybox')
if [ -n "$bblocation" ] && [ -e "$bblocation" ] ; then
        ui_print "Busybox found!";
        #strip possible leading '.'
        bblocation=${bblocation#.};
else
        ui_print "Busybox not found! init.d support will not work without busybox!";
        ui_print "Setting busybox location to /system/xbin/busybox! (install it and init.d will work)";
        #set default location since we couldn't find busybox
        bblocation="/system/xbin/busybox";
fi

#clean up unwanted tweaks
ui_print "Cleaning up unwanted tweaks, if any...";
rm -f /system/etc/init.d/04kernel >> /dev/null;
rm -f /system/etc/init.d/08mount >> /dev/null;
rm -f /system/etc/init.d/09modules >> /dev/null;
rm -f /system/etc/init.d/99cpu_thermal_limits >> /dev/null;
rm -f /system/etc/init.d/99epen_config >> /dev/null;
rm -f /system/etc/init.d/S91voltctrl >> /dev/null;
rm -f /system/etc/init.d/S98bolt_siyah >> /dev/null;
rm -f /system/etc/init.d/S_volt_scheduler >> /dev/null;
rm -f /system/etc/init.d/16journal >> /dev/null;
rm -f /res/misc/NEAK-Downloader.apk >> /dev/null;
rm -rf /data/neak >> /dev/null;
rm -f /res/neak.extra >> /dev/null;
rm -rf /sbin/near >> /dev/null;
rm -f /system/etc/lionheart >> /dev/null;
rm -f /system/etc/schedmc >> /dev/null;
rm -rf /system/.androidmeda >> /dev/null;
rm -rf /data/data/net.fluxi.xxTweaker >> /dev/null;
rm -rf /data/data/net.fluxi.xxTweak/ >> /dev/null;
rm -f /data/app/net.fluxi.xxTweaker-1.apk >> /dev/null;
rm -f /data/.notweaker >> /dev/null;
rm -rf /data/.Abyss/ >> /dev/null;
rm -rf /system/.Abyss/ >> /dev/null;
rm -f /sbin/ext/abyss.sh >> /dev/null;
rm -f /res/misc/S90abyss >> /dev/null;
rm -f /data/data/com.teamblockbuster.thoravukk.app >> /dev/null;
rm -f /data/app/com.teamblockbuster.thoravukk.app >> /dev/null;
rm -f /system/etc/init.d/thoravukk >> /dev/null;
rm -f /data/.thoravukk >> /dev/null;
rm -f /data/.bootcheck >> /dev/null;
rm -f /data/.frandom >> /dev/null;
rm -rf /data/.siyah >> /dev/null;
rm -rf /data/data/com.teamblockbuster >> /dev/null;
rm -f /system/litepro >> /dev/null;
rm -f /system/etc/init.d/99nstools >> /dev/null;
rm -f /system/etc/init.d/01zram-swap >> /dev/null;
rm -f /system/etc/init.d/zzCrossBreeder >> /dev/null;
rm -f /system/etc/init.d/06journal >> /dev/null;
rm -f /system/etc/init.d/08mount >> /dev/null;
rm -f /system/etc/init.d/98tweaks >> /dev/null;
rm -f /system/etc/init.d/S90zipalign >> /dev/null;
rm -f /system/etc/init.d/S70darky_zipalign >> /dev/null;
rm -f /system/etc/init.d/99Pimp_my_Rom >> /dev/null;
rm -f /system/etc/init.d/S97sqlite_optimize >> /dev/null;
rm -f /system/etc/init.d/S99complete >> /dev/null;
rm -f /system/etc/init.d/08setperm >> /dev/null;
rm -f /system/etc/init.d/S78enable_touchscreen_1 >> /dev/null;
rm -f /system/etc/init.d/S30edt_perms >> /dev/null;
rm -f /system/etc/init.d/S31edt_tweaks >> /dev/null;
rm -f /system/etc/init.d/S72Drop_Caches >> /dev/null;
rm -f /system/etc/init.d/S73Cleaner >> /dev/null;
rm -f /system/etc/init.d/S74Tweaks >> /dev/null;
rm -f /system/etc/init.d/S75More_Tweaks >> /dev/null;
rm -f /system/etc/init.d/S99_calibration >> /dev/null;
rm -f /system/etc/init.d/30enableloggers >> /dev/null;
rm -f /system/etc/init.d/30resetfuelgaugenextboot >> /dev/null;
rm -f /system/etc/init.d/01zram-swap >> /dev/null;
rm -f /system/etc/init.d/10enableUMS >> /dev/null;
rm -f /system/etc/init.d/10enableMTP >> /dev/null;
rm -f /system/etc/init.d/11nbmod >> /dev/null;
rm -f /system/etc/init.d/99elementalx >> /dev/null;
rm -f /system/etc/init.d/99mpdecRenamer >> /dev/null;
rm -f /system/etc/init.d/01mpdecision >> /dev/null;
rm -f /system/etc/init.d/00start >> /dev/null;
rm -f /system/etc/init.d/00banner >> /dev/null;
rm -f /system/etc/elementalx.conf >> /dev/null;
rm -rf /system/etc/rngd >> /dev/null;
rm -f /system/etc/init.d/Dash_Engine >> /dev/null;
rm -f /system/etc/init.d/sysctl_tweaks >> /dev/null; 
rm -f /system/etc/init.d/03Dash_boot >> /dev/null; 
rm -f /system/etc/init.d/01Dash_battery >> /dev/null; 
rm -f /system/etc/init.d/04Dash_cache >> /dev/null; 
rm -f /system/etc/init.d/10Dash_touchscreen >> /dev/null;
rm -f /system/etc/init.d/08Dash_sd >> /dev/null; 
rm -f /system/etc/init.d/02Dash_batteryceleb >> /dev/null; 
rm -f /system/etc/init.d/05Dash_cleaner >> /dev/null; 
rm -f /system/etc/init.d/06Dash_mainfree >> /dev/null; 
rm -f /system/etc/init.d/07Dash_netwroktweeks >> /dev/null; 
rm -f /system/etc/init.d/09Dash_sqlite_optimize >> /dev/null; 
rm -f /system/etc/init.d/11Dash_zipalign >> /dev/null; 
rm -f /system/etc/init.d/12Dash_zipaligndata >> /dev/null;
rm -f /system/etc/init.d/09sdcardspeedfix >> /dev/null;
rm -f /system/etc/init.d/10S_smoothness_tweak >> /dev/null;
rm -f /system/etc/init.d/S98CFSD >> /dev/null;
rm -f /system/etc/init.d/S98CFSE >> /dev/null;
rm -f /system/etc/init.d/S98CFSF >> /dev/null;
rm -f /system/etc/init.d/S98CFSG >> /dev/null;
rm -f /system/etc/init.d/S98CFSH >> /dev/null;
rm -f /system/etc/init.d/S98CFSI >> /dev/null;
rm -f /system/etc/init.d/S98CFSJ >> /dev/null;
rm -f /system/etc/init.d/S98CFSK >> /dev/null;
rm -f /system/etc/init.d/S98CFSL >> /dev/null;
rm -f /system/etc/init.d/S98CFSM >> /dev/null;
rm -f /system/etc/init.d/S98CFS_1.9.1 >> /dev/null;
rm -f /system/etc/init.d/S98CFS_2.1.1.1 >> /dev/null;
rm -f /system/etc/init.d/S98CFS_1.9.4 >> /dev/null;
rm -f /system/etc/init.d/S98CFSStock >> /dev/null;
rm -f /system/etc/init.d/S98CFS_1_9_1 >> /dev/null;
rm -f /system/etc/init.d/S98CFS_2_1_1_1 >> /dev/null;
rm -f /system/etc/init.d/S98CFS_1_9_4 >> /dev/null;
rm -f /system/etc/init.d/S99finish >> /dev/null;
rm -f /system/etc/init.d/89system_tweak >> /dev/null;
rm -f /system/etc/init.d/98fly_core >> /dev/null;
rm -f /system/etc/init.d/90screenstate_scaling >> /dev/null;
rm -f /system/etc/init.d/S97ramscript >> /dev/null;
rm -f /system/etc/init.d/S97rambooster >> /dev/null;
rm -f /system/etc/init.d/03sdcardspeedfix >> /dev/null;
rm -f /system/etc/init.d/04kerneltweaks >> /dev/null;
rm -f /system/etc/init.d/05sysctltweaks >> /dev/null;
rm -f /system/etc/init.d/98KickAssKernel >> /dev/null;
rm -f /system/etc/init.d/06tweaks >> /dev/null;
rm -f /system/etc/init.d/S01edt_sysctl >> /dev/null;
rm -f /system/etc/init.d/S98edt_tweaks >> /dev/null;
rm -f /system/etc/init.d/s99acidext4tweak >> /dev/null;
rm -f /system/etc/init.d/00remount >> /dev/null;
rm -f /system/etc/init.d/02Transform >> /dev/null;
rm -f /system/etc/init.d/01acid_sysctl >> /dev/null;
rm -f /system/etc/init.d/03sdcardspeedfix >> /dev/null;
rm -f /system/etc/init.d/04kerneltweaks >> /dev/null;
rm -f /system/etc/init.d/05sysctltweaks >> /dev/null;
rm -f /system/etc/init.d/S98CFSA >> /dev/null;
rm -f /system/etc/init.d/S98CFSB >> /dev/null;
rm -f /system/etc/init.d/nos_entropy_agg >> /dev/null;
rm -f /system/etc/init.d/nos_entropy_light >> /dev/null;
rm -f /system/etc/init.d/nos_entropy_mod >> /dev/null;
rm -f /system/etc/init.d/prof_mod >> /dev/null;
rm -f /system/etc/entropy/rngd_light >> /dev/null;
rm -f /system/etc/entropy/rngd_moderate >> /dev/null;
rm -f /system/etc/init.d/S98CFSC >> /dev/null;
rm -f /system/etc/init.d/s78enable_touchscreen_stock >> /dev/null;
rm -f /system/etc/init.d/s78enable_touchscreen_2 >> /dev/null;
rm -f /system/etc/init.d/net_buffer >> /dev/null;
rm -f /system/etc/init.d/ram_optimize >> /dev/null;
rm -f /system/etc/init.d/remount_fullext4 >> /dev/null;
rm -f /system/etc/init.d/ext4_lagfix >> /dev/null;
rm -f /system/etc/init.d/05LagFixer >> /dev/null;
rm -f /system/etc/init.d/S98system_tweak >> /dev/null;
rm -f /system/etc/init.d/05Fly_engine >> /dev/null;
rm -f /system/etc/init.d/Fly_engine >> /dev/null;
rm -f /system/etc/init.d/08Fly_engine >> /dev/null;
rm -f /system/etc/init.d/98system_tweak >> /dev/null;
rm -f /system/etc/init.d/ram_optimize >> /dev/null;
rm -f /system/etc/init.d/net_buffer >> /dev/null;
rm -f /system/etc/init.d/velocity_system >> /dev/null;
rm -f /system/etc/init.d/velocity_ram >> /dev/null;
rm -f /system/etc/init.d/s78sensitive_touchscreen >> /dev/null;
rm -f /system/etc/init.d/remountCM_fullext4 >> /dev/null;
rm -f /system/etc/init.d/02logdelete1 >> /dev/null;
rm -f /system/etc/init.d/04Governor_tweaks >> /dev/null;
rm -f /system/etc/init.d/entropy >> /dev/null;
rm -f /data/Fly-On/S08_rngd.log >> /dev/null;
rm -f /data/Fly-On/rngd_state >> /dev/null;
rm -f /system/etc/init.d/S98system_tweak >> /dev/null;
rm -f /system/xbin/rngd >> /dev/null;
rm -f /system/xbin/entro >> /dev/null;
rm -f /system/bin/entropy >> /dev/null;
rm -f /system/bin/nos_entropy >> /dev/null;
rm -f /system/bin/seeder >> /dev/null;
rm -rf /system/etc/entropy >> /dev/null;
rm -f /data/local/tmp/elementalx-kernel.log >> /dev/null;
rm -rf /system/etc/cron.d >> /dev/null;
rm -rf /system/lib/modules >> /dev/null;
rm -f /system/bin/Dash >> /dev/null;
rm -f /system/bin/undash >> /dev/null;
rm -f /system/bin/Dash-M >> /dev/null;
rm -f system/etc/init.d/00_frandom >> /dev/null;
rm -f system/etc/init.d/01_ftrim >> /dev/null;
rm -f system/etc/init.d/02_disableboost >> /dev/null;
rm -f system/etc/init.d/04_sweep2sleep >> /dev/null;
rm -f system/etc/init.d/05_dirtyratio >> /dev/null;
rm -f system/etc/init.d/99linaro >> /dev/null;
rm -f system/etc/init.d/00_uber >> /dev/null;
rm -f system/etc/init.d/01_fstrim >> /dev/null;
rm -f system/etc/init.d/02_cpuboost >> /dev/null;
rm -f system/etc/init.d/03_cputweaks >> /dev/null;
rm -f system/etc/init.d/96setenforce >> /dev/null;
rm -f system/etc/init.d/99fstrim >> /dev/null;

#add init.d support if not already supported
found=$(find /tmp/ramdisk/init.rc -type f | xargs grep -oh "run-parts /system/etc/init.d");
if [ "$found" == 'run-parts /system/etc/init.d' ] ||
   [ -e tmp/ramdisk/init.cm.rc ]; then
        ui_print "init.d support is pre-installed...";
else
	#append the new lines for this option at the bottom
        echo "" >> /tmp/ramdisk/init.rc
        echo "service userinit $bblocation run-parts /system/etc/init.d" >> /tmp/ramdisk/init.rc
        echo "    oneshot" >> /tmp/ramdisk/init.rc
        echo "    class late_start" >> /tmp/ramdisk/init.rc
        echo "    user root" >> /tmp/ramdisk/init.rc
        echo "    group root" >> /tmp/ramdisk/init.rc
        ui_print "init.d support is now installed...";
fi

#copy custom default.prop
cp -f /tmp/default.prop /tmp/ramdisk/default.prop
chmod 750 /tmp/ramdisk/default.prop

#copy custom init.shamu.rc
cp -f /tmp/init.shamu.rc /tmp/ramdisk/init.shamu.rc
chmod 750 /tmp/ramdisk/init.shamu.rc

#copy custom init.shamu.power.rc
cp -f /tmp/init.shamu.power.rc /tmp/ramdisk/init.shamu.power.rc
chmod 750 /tmp/ramdisk/init.shamu.power.rc

#copy custom fstab.shamu
cp -f /tmp/fstab.shamu /tmp/ramdisk/fstab.shamu
chmod 750 /tmp/ramdisk/fstab.shamu

rm /tmp/ramdisk/boot.img-ramdisk.gz
rm /tmp/boot.img-ramdisk.gz
cd /tmp/ramdisk/
find . | cpio -o -H newc | gzip > ../boot.img-ramdisk.gz
cd /
rm -rf /tmp/ramdisk

