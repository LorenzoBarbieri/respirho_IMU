#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include "nrf.h"
#include "bsp.h"
#include "hardfault.h"
#include "app_error.h"
#include "app_timer.h"
#include "nrf_drv_rtc.h"
#include "nrf_drv_clock.h"
#include "nrf_gpio.h"
#include "nrf_sdh.h"
#include "nrf_sdh_ant.h"
#include "nrf_pwr_mgmt.h"
#include "ant_interface.h"
#include "ant_parameters.h"
#include "ant_channel_config.h"
#define led_ant 17
#define led_timer 19
#include "nrf_log.h"
#include "nrf_log_ctrl.h"
#include "nrf_log_default_backends.h"

#define APP_ANT_OBSERVER_PRIO   1    /**< Application's ANT observer priority. You shouldn't need to modify this value. */

// ================= RTC program ========================== //
// Create a handle that will point to the RTC 2 of nrf device
const nrfx_rtc_t rtc = NRFX_RTC_INSTANCE(2); // rtc 2 handle

//clock initialization, not needed if softdevice is present
static void lfclk_config(void)
{
	// Initialize the low frequency clock 
  ret_code_t err_code = nrf_drv_clock_init();
  APP_ERROR_CHECK(err_code); // check for the errors

// Request the clock to not to generate events
  nrf_drv_clock_lfclk_request(NULL);
}

// RTC interrupt handler which will be used to handle the interrupt events
static void rtc_handler(nrfx_rtc_int_type_t int_type)
{
	// Check if the interrupt occurred due to tick event
    if(int_type == NRFX_RTC_INT_TICK)
    {
      // perform some action
      nrf_gpio_pin_toggle(led_timer);

     

    }


    else
    {
		// default action 
		// leave it empty
    }
	
}

// A function to configure and intialize the RTC
static void rtc_config(void)
{
	
    uint32_t err_code; // a variable to hold the error values

// Create a struct of type nrfx_rtc_config_t and assign it default values
    nrfx_rtc_config_t rtc_config = NRFX_RTC_DEFAULT_CONFIG;

// Configure the prescaler to generate ticks for a specific time unit
// Configured it to tick every 125ms 
    rtc_config.prescaler = 4095; // tick =  32768 / (4095 + 1) = 8Hz = 125ms

// Initialize the rtc and pass the configurations along with the interrupt handler
    err_code = nrfx_rtc_init(&rtc, &rtc_config, rtc_handler);
    APP_ERROR_CHECK(err_code); // check for errors

 
// Generate a tick event on each tick
 nrfx_rtc_tick_enable(&rtc, true);

// start the rtc 
    nrfx_rtc_enable(&rtc);


}


/**@brief Function for handling a ANT stack event.
 *
 * @param[in] p_ant_evt  ANT stack event.
 * @param[in] p_context  Context.
 */
void ant_evt_handler(ant_evt_t * p_ant_evt, void * p_context)
{
    ret_code_t err_code;

    if (p_ant_evt->channel == BROADCAST_CHANNEL_NUMBER)
    {
        switch (p_ant_evt->event)
        {
            case EVENT_RX:
                if (p_ant_evt->message.ANT_MESSAGE_ucMesgID == MESG_BROADCAST_DATA_ID
                 || p_ant_evt->message.ANT_MESSAGE_ucMesgID == MESG_ACKNOWLEDGED_DATA_ID
                 || p_ant_evt->message.ANT_MESSAGE_ucMesgID == MESG_BURST_DATA_ID)
                {
                    //err_code = bsp_indication_set(BSP_INDICATE_RCV_OK);
                    APP_ERROR_CHECK(err_code);
                    nrf_gpio_pin_toggle(led_ant);
                }
                break;

            default:
                break;
        }
    }
}

NRF_SDH_ANT_OBSERVER(m_ant_observer, APP_ANT_OBSERVER_PRIO, ant_evt_handler, NULL);

/**@brief Function for the Timer and BSP initialization.
 */
static void utils_setup(void)
{
    ret_code_t err_code = app_timer_init();
    APP_ERROR_CHECK(err_code);

    err_code = bsp_init(BSP_INIT_LEDS,
                        NULL);
    APP_ERROR_CHECK(err_code);

    err_code = nrf_pwr_mgmt_init();
    APP_ERROR_CHECK(err_code);
}

/**@brief Function for ANT stack initialization.
 */
static void softdevice_setup(void)
{
    ret_code_t err_code = nrf_sdh_enable_request();
    APP_ERROR_CHECK(err_code);

    ASSERT(nrf_sdh_is_enabled());

    err_code = nrf_sdh_ant_enable();
    APP_ERROR_CHECK(err_code);
}

/**@brief Function for setting up the ANT module to be ready for RX broadcast.
 */
static void ant_channel_rx_broadcast_setup(void)
{
    ant_channel_config_t broadcast_channel_config =
    {
        .channel_number    = BROADCAST_CHANNEL_NUMBER,
        .channel_type      = CHANNEL_TYPE_SLAVE,
        .ext_assign        = 0x00,
        .rf_freq           = RF_FREQ,
        .transmission_type = CHAN_ID_TRANS_TYPE,
        .device_type       = CHAN_ID_DEV_TYPE,
        .device_number     = CHAN_ID_DEV_NUM,
        .channel_period    = CHAN_PERIOD,
        .network_number    = ANT_NETWORK_NUM,
    };

    ret_code_t err_code = ant_channel_init(&broadcast_channel_config);
    APP_ERROR_CHECK(err_code);

    // Open channel.
    err_code = sd_ant_channel_open(BROADCAST_CHANNEL_NUMBER);
    APP_ERROR_CHECK(err_code);
}

/**
 *@brief Function for initializing logging.
 */
static void log_init(void)
{
    ret_code_t err_code = NRF_LOG_INIT(NULL);
    APP_ERROR_CHECK(err_code);

    NRF_LOG_DEFAULT_BACKENDS_INIT();
}

/**@brief Function for application main entry. Does not return.
 */
int main(void)
{
    log_init();
    utils_setup();
    softdevice_setup();
    ant_channel_rx_broadcast_setup();
    nrf_gpio_cfg_output(led_ant);
    nrf_gpio_cfg_output(led_timer);
    
    //lfclk_config();
    rtc_config();

    NRF_LOG_INFO("ANT Broadcast RX example started.");

    // Main loop.
    for (;;)
    {
        NRF_LOG_FLUSH();
        nrf_pwr_mgmt_run();
        //__SEV();
        // __WFE();
        //__WFE();
    }
}


/**
 *@}
 **/
