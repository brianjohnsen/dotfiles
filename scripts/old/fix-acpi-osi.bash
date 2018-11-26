#!/bin/sh

# Script that fixes all sorts of suspend/resume issues.
## See http://iam.tj/prototype/enhancements/Windows-acpi_osi.html
echo "Setting acpi_osi value..."
VERSION="$(sudo strings /sys/firmware/acpi/tables/DSDT | grep -i 'windows ' | sort | tail -1)"
echo 'Linux kernel command-line options required: acpi_osi=! "acpi_osi='$VERSION'"'
echo "Existing Command Line: ` sed -n '/.*linux[[:space:]].*root=\(.*\)/{s//BOOT_IMAGE=\1/ p;q;}' /boot/grub/grub.cfg `"
sudo sed -i "s/^\(GRUB_CMDLINE_LINUX=.*\)\"$/\1 acpi_osi=! \\\\\"acpi_osi=$VERSION\\\\\"\"/" /etc/default/grub
echo "Modified Command Line: ` sed -n '/.*linux[[:space:]].*root=\(.*\)/{s//BOOT_IMAGE=\1/ p;q;}' /boot/grub/grub.cfg `"
sudo update-grub
