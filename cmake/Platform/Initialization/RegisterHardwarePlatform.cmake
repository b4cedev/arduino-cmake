if (NOT PLATFORM_PATH)
    if (NOT PLATFORM_ARCHITECTURE)
        # avr is the default architecture
        set(PLATFORM_ARCHITECTURE "avr")
    endif ()

    # Arduino is assumed as the default platform
    set(PLATFORM_PATH ${ARDUINO_SDK_PATH}/hardware/arduino/${PLATFORM_ARCHITECTURE})
endif ()
string(REGEX REPLACE "/$" "" PLATFORM_PATH ${PLATFORM_PATH})
get_filename_component(PLATFORM_ARCHITECTURE ${PLATFORM_PATH} NAME)
get_filename_component(VENDOR_PATH ${PLATFORM_PATH} DIRECTORY)
get_filename_component(VENDOR_ID ${VENDOR_PATH} NAME)
get_filename_component(BASE_PATH ${VENDOR_PATH} DIRECTORY)

if (CUSTOM_PLATFORM_REGISTRATION_SCRIPT)
    include("${CUSTOM_PLATFORM_REGISTRATION_SCRIPT}")
else ()
    include(RegisterSpecificHardwarePlatform)
endif ()
