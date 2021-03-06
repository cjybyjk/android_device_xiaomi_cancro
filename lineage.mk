# Copyright (C) 2014 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
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

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from cancro device
$(call inherit-product, device/xiaomi/cancro/cancro.mk)

PRODUCT_NAME := lineage_cancro
PRODUCT_DEVICE := cancro
PRODUCT_BRAND := Xiaomi
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := MI Cancro

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

TARGET_CONTINUOUS_SPLASH_ENABLED := true

TARGET_VENDOR := Xiaomi
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="cancro-user 6.0.1 MMB29M V8.1.6.0.MXDMIDI release-keys"

BUILD_FINGERPRINT=Xiaomi/cancro/cancro:6.0.1/MMB29M/V8.1.6.0.MXDMIDI:user/release-keys
