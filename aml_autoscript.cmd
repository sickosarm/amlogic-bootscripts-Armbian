if printenv bootfromsd; then exit; else setenv ab 0; fi;
setenv bootcmd 'run start_autoscript; run storeboot'
setenv start_autoscript 'if mmcinfo; then run start_mmc_autoscript; fi; if usb start; then run start_usb_autoscript; fi; run start_emmc_autoscript'
setenv start_emmc_autoscript 'if fatload mmc 1 1020000 emmc_autoscript; then setenv devtype "mmc"; setenv devnum 1; autoscr 1020000; fi;'
setenv start_mmc_autoscript 'if fatload mmc 0 1020000 s905_autoscript; then setenv devtype "mmc"; setenv devnum 0; autoscr 1020000; fi;'
setenv start_usb_autoscript 'for usbdev in 0 1 2 3; do if fatload usb ${usbdev} 1020000 s905_autoscript; then setenv devtype "usb"; setenv devnum 0; autoscr 1020000; fi; done'
setenv upgrade_step 2
saveenv
sleep 1
reboot

# Recompile with:
# mkimage -C none -A arm -T script -d aml_autoscript.cmd aml_autoscript
