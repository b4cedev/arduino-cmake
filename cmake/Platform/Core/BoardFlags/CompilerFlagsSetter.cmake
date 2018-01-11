# ToDo: Comment
function(set_board_compiler_flags COMPILER_FLAGS NORMALIZED_SDK_VERSION BOARD_ID IS_MANUAL)

    _try_get_board_property(${BOARD_ID} build.f_cpu FCPU)
    if(NOT "${FCPU}" STREQUAL "")
       set(COMPILE_FLAGS "-DF_CPU=${FCPU}")
    endif()
    
    _try_get_board_property(${BOARD_ID} build.mcu MCU)    
    if(NOT "${MCU}" STREQUAL "")
       set(COMPILE_FLAGS "${COMPILE_FLAGS} -mmcu=${MCU}")
    endif()
    
    set(COMPILE_FLAGS "${COMPILE_FLAGS} -DARDUINO=${NORMALIZED_SDK_VERSION}")

    _try_get_board_property(${BOARD_ID} build.vid VID)
    _try_get_board_property(${BOARD_ID} build.pid PID)
    if (VID)
        set(COMPILE_FLAGS "${COMPILE_FLAGS} -DUSB_VID=${VID}")
    endif ()
    if (PID)
        set(COMPILE_FLAGS "${COMPILE_FLAGS} -DUSB_PID=${PID}")
    endif ()
    
    _try_get_board_property(${BOARD_ID} build.extra_flags EXTRA_FLAGS)

    if(NOT "${EXTRA_FLAGS}" STREQUAL "")
        set(COMPILE_FLAGS "${COMPILE_FLAGS} ${EXTRA_FLAGS}")
    endif()
    
    _try_get_board_property(${BOARD_ID} build.usb_flags USB_FLAGS)
    if(NOT "${USB_FLAGS}" STREQUAL "")
        set(COMPILE_FLAGS "${COMPILE_FLAGS} ${USB_FLAGS}")
    endif()

    if (NOT IS_MANUAL)
        _get_board_property(${BOARD_ID} build.core BOARD_CORE)
        set(COMPILE_FLAGS "${COMPILE_FLAGS} -I\"${${BOARD_CORE}.path}\" -I\"${ARDUINO_LIBRARIES_PATH}\"")
        if (${ARDUINO_PLATFORM_LIBRARIES_PATH})
            set(COMPILE_FLAGS "${COMPILE_FLAGS} -I\"${ARDUINO_PLATFORM_LIBRARIES_PATH}\"")
        endif ()
    endif ()
    if (ARDUINO_SDK_VERSION VERSION_GREATER 1.0 OR ARDUINO_SDK_VERSION VERSION_EQUAL 1.0)
        if (NOT IS_MANUAL)
            _get_board_property(${BOARD_ID} build.variant VARIANT)
            set(PIN_HEADER ${${VARIANT}.path})
            if (PIN_HEADER)
                set(COMPILE_FLAGS "${COMPILE_FLAGS} -I\"${PIN_HEADER}\"")
            endif ()
        endif ()
    endif ()

    set(${COMPILER_FLAGS} "${COMPILE_FLAGS}" PARENT_SCOPE)

endfunction()