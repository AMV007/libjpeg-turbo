LOCAL_PATH:= $(call my-dir)

# Set up common variables for usage across the libjpeg-turbo modules

# By default, the build system generates ARM target binaries in thumb mode,
# where each instruction is 16 bits wide.  Defining this variable as arm
# forces the build system to generate object files in 32-bit arm mode.  This
# is the same setting previously used by libjpeg and it provides a small
# performance benefit.
libjpeg_turbo_common_arm_mode := arm

libjpeg_turbo_common_cflags := -O3 -fstrict-aliasing
libjpeg_turbo_common_cflags += -Wno-unused-parameter -Werror

# If we are certain that the ARM v7 device has NEON (and there is no need for
# a runtime check), we can indicate that with a flag.
# ifeq ($(strip $(TARGET_ARCH)),arm)
#   ifeq ($(ARCH_ARM_HAVE_NEON),true)
#     libjpeg_turbo_common_cflags += -D__ARM_HAVE_NEON__
#   endif
# endif

libjpeg_turbo_common_src_files := \
    jcapimin.c jcapistd.c jccoefct.c jccolor.c jcdctmgr.c jchuff.c \
    jcinit.c jcmainct.c jcmarker.c jcmaster.c jcomapi.c jcparam.c \
    jcphuff.c jcprepct.c jcsample.c jctrans.c jdapimin.c jdapistd.c \
    jdatadst.c jdatasrc.c jdcoefct.c  jdcolor.c jddctmgr.c jdhuff.c \
    jdinput.c jdmainct.c jdmarker.c jdmaster.c jdmerge.c jdphuff.c \
    jdpostct.c jdsample.c jdtrans.c jerror.c jfdctflt.c jfdctfst.c \
    jfdctint.c jidctflt.c jidctfst.c jidctint.c jidctred.c jmemmgr.c \
    jmemnobs.c jquant1.c jquant2.c jutils.c

# ARM v7 NEON
#libjpeg_turbo_common_src_files_arm := simd/jsimd_arm_neon.S simd/jsimd_arm.c
libjpeg_turbo_common_src_files += jsimd_none.c

# ARM v8 64-bit NEON
#libjpeg_turbo_common_src_files_arm64 := simd/jsimd_arm64_neon.S simd/jsimd_arm64.c

# x86 MMX and SSE2
# libjpeg_turbo_common_src_files_x86 := \
#       simd/jsimd_i386.c simd/jccolor-mmx.asm simd/jccolor-sse2.asm \
#       simd/jcgray-mmx.asm  simd/jcgray-sse2.asm simd/jchuff-sse2.asm \
#       simd/jcsample-mmx.asm simd/jcsample-sse2.asm simd/jdcolor-mmx.asm \
#       simd/jdcolor-sse2.asm simd/jdmerge-mmx.asm simd/jdmerge-sse2.asm \
#       simd/jdsample-mmx.asm simd/jdsample-sse2.asm simd/jfdctflt-3dn.asm \
#       simd/jfdctflt-sse.asm simd/jfdctfst-mmx.asm simd/jfdctfst-sse2.asm \
#       simd/jfdctint-mmx.asm simd/jfdctint-sse2.asm simd/jidctflt-3dn.asm \
#       simd/jidctflt-sse2.asm simd/jidctflt-sse.asm simd/jidctfst-mmx.asm \
#       simd/jidctfst-sse2.asm simd/jidctint-mmx.asm simd/jidctint-sse2.asm \
#       simd/jidctred-mmx.asm simd/jidctred-sse2.asm simd/jquant-3dn.asm \
#       simd/jquantf-sse2.asm simd/jquanti-sse2.asm simd/jquant-mmx.asm \
#       simd/jquant-sse.asm simd/jsimdcpu.asm

# # x86-64 SSE2
# libjpeg_turbo_common_src_files_x86_64 := \
#       simd/jsimd_x86_64.c simd/jccolor-sse2-64.asm simd/jcgray-sse2-64.asm \
#       simd/jchuff-sse2-64.asm simd/jcsample-sse2-64.asm simd/jdcolor-sse2-64.asm \
#       simd/jdmerge-sse2-64.asm simd/jdsample-sse2-64.asm simd/jfdctflt-sse-64.asm \
#       simd/jfdctfst-sse2-64.asm simd/jfdctint-sse2-64.asm simd/jidctflt-sse2-64.asm \
#       simd/jidctfst-sse2-64.asm simd/jidctint-sse2-64.asm simd/jidctred-sse2-64.asm \
#       simd/jquantf-sse2-64.asm simd/jquanti-sse2-64.asm

# MIPS and MIPS64
#libjpeg_turbo_common_src_files_mips := jsimd_none.c

# Common ASFLAGS for x86/x86_64
#libjpeg_turbo_common_asflags := -DPIC -DELF

include $(CLEAR_VARS)

LOCAL_ARM_MODE := $(libjpeg_turbo_common_arm_mode)

LOCAL_SRC_FILES := $(libjpeg_turbo_common_src_files)

LOCAL_SRC_FILES_arm += $(libjpeg_turbo_common_src_files_arm)

LOCAL_SRC_FILES_arm64 += $(libjpeg_turbo_common_src_files_arm64)

LOCAL_SRC_FILES_x86 += $(libjpeg_turbo_common_src_files_x86)
LOCAL_ASFLAGS_x86 += $(libjpeg_turbo_common_asflags)
LOCAL_C_INCLUDES_x86 += $(LOCAL_PATH)/simd

# x86-64 SSE2
LOCAL_SRC_FILES_x86_64 += $(libjpeg_turbo_common_src_files_x86_64)
LOCAL_ASFLAGS_x86_64 += -D__x86_64__ $(libjpeg_turbo_common_asflags)
LOCAL_C_INCLUDES_x86_64 += $(LOCAL_PATH)/simd

LOCAL_SRC_FILES_mips += $(libjpeg_turbo_common_src_files_mips)
LOCAL_SRC_FILES_mips64 += $(libjpeg_turbo_common_src_files_mips)

LOCAL_CFLAGS += $(libjpeg_turbo_common_cflags)
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)

ifneq (,$(TARGET_BUILD_APPS))
  # Unbundled branch, built against NDK.
  LOCAL_SDK_VERSION := 17
endif

# Build as a static library.
LOCAL_MODULE := libjpeg_static
include $(BUILD_STATIC_LIBRARY)

# # Also build as a shared library.
# include $(CLEAR_VARS)

# ifneq (,$(TARGET_BUILD_APPS))
#   # Unbundled branch, built against NDK.
#   LOCAL_SDK_VERSION := 17
# endif

# LOCAL_WHOLE_STATIC_LIBRARIES = libjpeg_static
# LOCAL_MODULE := libjpeg
# include $(BUILD_SHARED_LIBRARY)


# Build static library against the NDK
# include $(CLEAR_VARS)

# LOCAL_ARM_MODE := $(libjpeg_turbo_common_arm_mode)

# LOCAL_SRC_FILES := $(libjpeg_turbo_common_src_files)

# LOCAL_SRC_FILES_arm += $(libjpeg_turbo_common_src_files_arm)

# LOCAL_SRC_FILES_arm64 += $(libjpeg_turbo_common_src_files_arm64)

# LOCAL_SRC_FILES_x86 += $(libjpeg_turbo_common_src_files_x86)

# LOCAL_ASFLAGS_x86 += $(libjpeg_turbo_common_asflags)
# LOCAL_C_INCLUDES_x86 += $(LOCAL_PATH)/simd

# LOCAL_SRC_FILES_x86_64 += $(libjpeg_turbo_common_src_files_x86_64)
# LOCAL_ASFLAGS_x86_64 += -D__x86_64__ $(libjpeg_turbo_common_asflags)
# LOCAL_C_INCLUDES_x86_64 += $(LOCAL_PATH)/simd

# LOCAL_SRC_FILES_mips += $(libjpeg_turbo_common_src_files_mips)
# LOCAL_SRC_FILES_mips64 += $(libjpeg_turbo_common_src_files_mips)

# LOCAL_CFLAGS += $(libjpeg_turbo_common_cflags)
# LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)

# LOCAL_SDK_VERSION := 17

# # Build as a static library.
# LOCAL_MODULE := libjpeg_static_ndk
# include $(BUILD_STATIC_LIBRARY)

# Definition for TJBench
# include $(CLEAR_VARS)

# LOCAL_MODULE := tjbench

# LOCAL_WHOLE_STATIC_LIBRARIES = libjpeg_static

# LOCAL_MODULE_STEM_32 := tj32
# LOCAL_MODULE_STEM_64 := tj64

# LOCAL_MULTILIB := both

# LOCAL_CFLAGS += -DBMP_SUPPORTED -DPPM_SUPPORTED

# LOCAL_SRC_FILES := tjbench.c bmp.c tjutil.c rdbmp.c rdppm.c \
#                    wrbmp.c wrppm.c turbojpeg.c transupp.c jdatadst-tj.c \
#                    jdatasrc-tj.c

# include $(BUILD_EXECUTABLE)

# Unset all created common variables
libjpeg_turbo_common_arm_mode :=
libjpeg_turbo_common_src_files :=
libjpeg_turbo_common_src_files_arm :=
libjpeg_turbo_common_src_files_arm64 :=
libjpeg_turbo_common_src_files_x86 :=
libjpeg_turbo_common_src_files_x86_64 :=
libjpeg_turbo_common_asflags :=
libjpeg_turbo_common_src_files_mips :=
libjpeg_turbo_common_cflags :=
