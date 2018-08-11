#!/sbin/sh
#
# Copyright (C) 2016 CyanogenMod Project
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

RAW_ID=`cat /sys/devices/system/soc/soc0/raw_id`

# $1:path/to/file
kill_file() {
    if [ "" != "$1" ]; then 
        chmod 0777 -R $1
        rm -rf $1
    fi
}
# $1:source $2:target
force_move_file() {
    if [ "" != "$1" ] && [ "" != "$2" ]; then 
        orig_perm=`ls -l $2 | awk '{print \$1}'`
        orig_u=`echo ${orig_perm:1:3}`
        orig_g=`echo ${orig_perm:4:3}`
        orig_o=`echo ${orig_perm:7:3}`
        kill_file "$2"
        mv "$1" "$2"
        chmod u=${orig_u//-/},g=${orig_g//-/},o=${orig_o//-/} "$2"
    fi
}

mount /dev/block/bootdevice/by-name/vendor /vendor
mount /dev/block/bootdevice/by-name/system /system

if [ $RAW_ID == 1974 ] || [ $RAW_ID == 1972 ]; then
    # Replace manifests
    force_move_file /vendor/manifest_mi4.xml /vendor/manifest.xml
    # Remove NFC
    kill_file /system/app/NfcNci
    kill_file /system/priv-app/Tag
    kill_file /vendor/lib/*nfc*
    kill_file /vendor/etc/*nfc*
    kill_file /vendor/etc/permissions/*nfc*
    kill_file /vendor/vendor/firmware/*bcm*
    kill_file /vendor/lib/hw/android.hardware.nfc@1.0-impl-bcm.so
    kill_file /vendor/bin/hw/android.hardware.nfc@1.0-service
    kill_file /vendor/lib/android.hardware.nfc@1.0.so
    # Use Mi4 audio configs
    kill_file /vendor/etc/acdbdata/MTP/MTP_Speaker_cal.acdb
    force_move_file /vendor/etc/acdbdata/MTP/MTP_Speaker_cal_4.acdb /vendor/etc/acdbdata/MTP/MTP_Speaker_cal.acdb
    kill_file /vendor/etc/mixer_paths.xml
    force_move_file /vendor/etc/mixer_paths_4.xml /vendor/etc/mixer_paths.xml
    # Mi4 libdirac config
    kill_file /vendor/etc/diracmobile.config
    force_move_file /vendor/etc/diracmobile_4.config /vendor/etc/diracmobile.config
else
    # Remove Mi4 consumerir support
    kill_file /vendor/etc/permissions/android.hardware.consumerir.xml
    kill_file /vendor/lib/hw/consumerir.msm8974.so
    kill_file /vendor/lib/hw/android.hardware.ir@*.so
    kill_file /vendor/bin/hw/android.hardware.ir@*
    kill_file /vendor/manifest_mi4.xml
    # Remove Mi4 audio configs
    kill_file /vendor/etc/acdbdata/MTP/MTP_Speaker_cal_4.acdb
    kill_file /vendor/etc/mixer_paths_4.xml
    # Remove Mi4 libdirac config
    kill_file /vendor/etc/diracmobile_4.config
fi

umount /vendor
umount /system

if [ $RAW_ID == 1978 ] || [ $RAW_ID == 1974 ] || [ $RAW_ID == 1972 ]; then
    # Supported device (Mi3w - 1978 or Mi4 - 1974)
    return 0
else
    # Unsupported device
    return 1
fi
