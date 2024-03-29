# Make command-line Options for Optiboot, Optiboot-Mega0
# Permit commands like "make atmega4809 LED_START_FLASHES=10" to pass the
# appropriate parameters ("-DLED_START_FLASHES=10") to gcc
#

ifdef PRODUCTION
ifneq ($(PRODUCTION),0)
VERSION_CMD = -DPRODUCTION=1
endif
dummy = FORCE
endif


# Build Options

ifdef CUSTOM_VERSION
ifneq ($(CUSTOM_VERSION), 0)
VERSION_CMD = -DOPTIBOOT_CUSTOMVER=$(CUSTOM_VERSION)
else
VERSION_CMD = -DPRODUCTION=1
endif
dummy = FORCE
endif

# BIGBOOT: Include extra features, up to 1K.
ifdef BIGBOOT
ifneq ($(BIGBOOT), 0)
BIGBOOT_CMD = -DBIGBOOT=1
dummy = FORCE
endif
endif

ifdef SUPPORT_EEPROM
ifneq ($(SUPPORT_EEPROM), 0)
SUPPORT_EEPROM_CMD = -DSUPPORT_EEPROM
dummy = FORCE
endif
endif

ifdef NO_APP_SPM
ifneq ($(NO_APP_SPM),0)
APPSPM_CMD = -DAPP_NOSPM=1
endif
endif


# LED options

ifdef LED
LED_CMD = -DLED=$(LED)
dummy = FORCE
endif

ifdef LED_START_FLASHES
LED_START_FLASHES_CMD = -DLED_START_FLASHES=$(LED_START_FLASHES)
dummy = FORCE
else
LED_START_FLASHES_CMD = -DLED_START_FLASHES=3
endif

ifdef LED_DATA_FLASH
ifneq ($(LED_DATA_FLASH), 0)
LED_DATA_FLASH_CMD = -DLED_DATA_FLASH=1
dummy = FORCE
endif
endif

ifdef LED_START_ON
ifneq ($(LED_START_ON), 0)
LED_START_ON_CMD = -DLED_START_ON=1
endif
dummy = FORCE
endif

ifdef LED_INVERT
ifneq ($(LED_INVERT), 0)
LEDINV_CMD = -DLED_INVERT=1
endif
dummy = FORCE
endif


# UART options

ifdef BAUD_RATE
BAUD_RATE_CMD = -DBAUD_RATE=$(BAUD_RATE)
dummy = FORCE
else
BAUD_RATE_CMD = -DBAUD_RATE=115200
endif

ifdef SOFT_UART
ifneq ($(SOFT_UART), 0)
SOFT_UART_CMD = -DSOFT_UART=1
dummy = FORCE
endif
endif

ifdef SINGLESPEED
ifneq ($(SINGLESPEED), 0)
SS_CMD = -DSINGLESPEED=1
endif
endif


#CPU Options

ifdef TIMEOUT
TIMEOUT_CMD = -DWDTTIME=$(TIMEOUT)
dummy = FORCE
endif

ifdef RESETPIN
RESETPIN_CMD = -DRSTPIN=$(RESETPIN)
dummy = FORCE
endif

ifdef AVR_FREQ
FCPU_CMD = -DF_CPU=$(AVR_FREQ)
dummy = FORCE
endif



LED_OPTIONS = $(LED_START_FLASHES_CMD) $(LED_DATA_FLASH_CMD) $(LED_CMD) $(LED_START_ON_CMD) $(LEDINV_CMD)
CPU_OPTIONS = $(RESETPIN_CMD) $(TIMEOUT_CMD) $(FCPU_CMD)
COMMON_OPTIONS =  $(BIGBOOT_CMD) $(APPSPM_CMD) $(VERSION_CMD)
COMMON_OPTIONS += $(SUPPORT_EEPROM_CMD)

#UART is handled separately and only passed for devices with more than one.
ifdef UART
UART_CMD = -DUART=$(UART)
endif
ifdef UARTTX
UART_CMD = -DUARTTX=$(UARTTX)
endif

UART_OPTIONS = $(UART_CMD) $(BAUD_RATE_CMD) $(SOFT_UART_CMD) $(SS_CMD)

ifneq ($(SKIP_BOOTLOADER_ON_POR),0)
POR = -DSTART_APP_ON_POR
endif
