/***
 *    The protocols are stored in '../Protocols/BehaviourProtocols.csv'. A
 *    protocol is chosen at build time by passing -DPROTO_CODE option to cmake.
 *    A python script '../Protocols/protocol_to_config.py" converts a given
 *    protocol to protocol.h file.
 *
 *         Author:  Dilawar Singh <dilawars@ncbs.res.in>
 *   Organization:  NCBS Bangalore
 *
 *        License:  GNU GPLv3
 *
 *  See the GIT changelog for more details.
 */

#include <avr/wdt.h>

// Pin configurations and other global variables.
#include "config.h"

// Helper methods. This also have global variables.
#include "methods.h"

// Protocol information is in this file. Note that this file is generated by
// build system (cmake) at configuration time.
#include "protocol.h"


void setup()
{
    // Set the highest baud rate possible. The value of x for baud rate is
    // rougly x/10 char per seconds or x/1000 char per 10 ms. We want rougly 100
    // chars per ms i.e. baud rate should be higher than 100,000.
    Serial.begin( 115200 );


    // Random seed.
    randomSeed( analogRead(A5) );

    //esetup watchdog. If not reset in 2 seconds, it reboots the system.
    stamp_ = millis( );

    pinMode(SHOCK_PWM_PIN, OUTPUT);
    pinMode(SHOCK_STIM_ISOLATER_PIN, OUTPUT);

    pinMode( SHOCK_RELAY_PIN_CHAN_12, OUTPUT);
    pinMode( SHOCK_RELAY_PIN_CHAN_34, OUTPUT);

    // CS AND US
    pinMode( TONE_PIN, OUTPUT );
    pinMode( PUFF_PIN, OUTPUT );
    pinMode( LED_PIN, OUTPUT );

    pinMode( CAMERA_TTL_PIN, OUTPUT );
    pinMode( IMAGING_TRIGGER_PIN, OUTPUT );

    // Rotary encode
    pinMode(ROTARY_ENC_A, INPUT);
    pinMode(ROTARY_ENC_B, INPUT);

    digitalWrite(ROTARY_ENC_A, HIGH); //turn pullup resistor on
    digitalWrite(ROTARY_ENC_B, HIGH); //turn pullup resistor on

    // NOTE: This changes with board. Testing with UNO. The above snippet is
    // preferred when available.
    attachInterrupt(0, ISR_ON_PIN2, RISING);
    attachInterrupt(1, ISR_ON_PIN3, RISING);

    // It is in Shocker.h file.
    configureShockingTimer();

    // setup watchdog. If not reset in 2 seconds, it reboots the system.
    wdt_enable( WDTO_2S );
    wdt_reset();
    
    print_trial_info( );
    wait_for_start( );
}

void do_zero_trial( )
{
    return;
}

void do_first_trial( )
{
    return;
}

/**
 * @brief Just for testing.
 *
 * @param duration
 */
void do_empty_trial( size_t trialNum, int duration = 10 )
{
    Serial.print( ">> TRIAL NUM: " );
    Serial.println( trialNum );
    //print_trial_info( );
    delay( duration );
    Serial.println( ">>     TRIAL OVER." );
}

void wait_and_print( size_t howlong )  // ms
{
    int s = millis();
    while( millis() - s <= howlong )
        write_data_line();
}


/**
 * @brief Do a single trial.
 *
 * @param trialNum. Index of the trial.
 * @param ttype. Type of the trial.
 */
void do_trial( size_t trialNum, bool isprobe = false )
{
    reset_watchdog( );
    check_for_reset( );

    print_trial_info( );
    trial_start_time_ = millis( );

    /*-----------------------------------------------------------------------------
     * PRE. Start imaging;
     * Usually durations of PRE_ is 8000 ms. For some trials is it randomly
     * chosen between 6000 ms and 8000 ms. See protocol.h file and
     * ./Protocols/BehaviourProtocols.csv file.
     *
     * In second version: this time is computed by cmake on the fly.
     *-----------------------------------------------------------------------------*/
    size_t duration = intervalPRE.end - intervalPRE.start;
    callbackData_.trialNum = trialNum;
    callbackData_.isProbe = isprobe;

    stamp_ = millis();
    intervalPRE.callbackStart();
    // What happens during PRE.
    while( (millis( ) - trial_start_time_ ) <= duration ) /* PRE_ time */
    {
        // 500 ms before the PRE_ ends, start camera pin high. We start
        // recording as well.
        if( (millis( ) - stamp_) >= (duration - 500 ) )
        {
            if( LOW == digitalRead( CAMERA_TTL_PIN ) )
            {
                digitalWrite( CAMERA_TTL_PIN, HIGH );
            }
        }
        write_data_line( );
    }
    stamp_ = millis( );
    intervalPRE.callbackEnd();

    /*-----------------------------------------------------------------------------
     *  CS: 50 ms duration.
     *-----------------------------------------------------------------------------*/
    duration = intervalCS.end - intervalCS.start;
    intervalCS.callbackStart();

    stamp_ = millis( );

#if 0
    /*-----------------------------------------------------------------------------
     *  TRACE. The duration of trace varies from trial to trial. If US is shock
     *  then 10ms before the US, switch on the relay pin.
     *-----------------------------------------------------------------------------*/
    if(String(PROTO_USValue) == String("SHOCK"))
        duration = PROTO_TraceDuration - 10;
    else
        duration = PROTO_TraceDuration;

    sprintf( trial_state_, "TRAC" );
    while( (millis() - stamp_) <= duration )
        write_data_line();
    stamp_ = millis();

    if(String(PROTO_USValue) == String("SHOCK"))
    {
        //Serial.println( ">>>Disabled SHOCKPAD." );
        disableReadingShockPad();
        delay(10);
    }

    /*-----------------------------------------------------------------------------
     *  US for 50 ms if trial is not a probe type.
     *-----------------------------------------------------------------------------*/
    duration = PROTO_USDuration;
    if(isprobe)
    {
        sprintf( trial_state_, "PROB" );
        while( (millis( ) - stamp_) <= duration )
            write_data_line( );
    }
    else
    {
        sprintf( trial_state_, PROTO_USValue );
        if(String(PROTO_USValue) == String("SHOCK"))
        {
            //Serial.println( ">>> DELIVER shock");
            deliverShock(duration);
        }
        else if(String(PROTO_USValue) == String("PUFF"))
            play_puff( duration );
        else
        {
            while( (millis( ) - stamp_) <= duration )
                write_data_line( );
        }
    }

    // POST has started.
    stamp_ = millis( );
    sprintf( trial_state_, "POST" );
    if(String(PROTO_USValue) == String("SHOCK"))
    {
        delay(10);
        //Serial.println( ">>>Enabled SHOCKPAD." );
        enableReadingShockPad();
    }

    /*-----------------------------------------------------------------------------
     *  POST, flexible duration till trial is over. It is 8 second long.
     *-----------------------------------------------------------------------------*/
    // Last phase is post. If we are here just spend rest of time here.
    duration = PROTO_PostStimDuration;
    while( (millis( ) - stamp_) <= duration )
    {
        write_data_line( );
        // Switch camera OFF after 2500 ms into POST.
        if( (millis() - stamp_) >= 2500 )
            digitalWrite( CAMERA_TTL_PIN, LOW );
    }

    digitalWrite( IMAGING_TRIGGER_PIN, LOW ); /* Shut down the imaging. */

    /*-----------------------------------------------------------------------------
     *  ITI.
     *-----------------------------------------------------------------------------*/
    unsigned long rduration = random(23000, 25001);
    Serial.print(">>Trial is over. Waiting "); 
    Serial.print(rduration - stamp_);
    Serial.println(" ms (ITI) before starting new trial." );
    stamp_ = millis();
    sprintf(trial_state_, "ITI_");
    while((millis() - stamp_) <= rduration)
    {
        reset_watchdog();
        write_data_line();
        delay(200);
    }
#endif 
}

void loop()
{
    reset_watchdog();

    // Initialize probe trials index. Mean 6 +/- 2 trials.
    unsigned numProbeTrials = 0;
    unsigned nextProbeTrialIndex = random(5, 10);

    for (size_t i = 1; i <= PROTO_NumTrialsInABlock; i++)
    {
        check_for_reset();
        reset_watchdog();
        trial_count_ = i;

        if(String("TONE/LIGHT") == String(intervalCS.value))
        {
            // FOR Shomu. Mixed trials.
            bool isprobe = false;
            if( i % 5 == 0 )
                isprobe = true;
            do_trial(i, isprobe );
        }
        else
        {
            bool isprobe = false;
            // Probe trial.
            if( i == nextProbeTrialIndex )
            {
                isprobe = true;
                numProbeTrials +=1 ;
                nextProbeTrialIndex = random( (numProbeTrials+1)*10-2, (numProbeTrials+1)*10+3);
            }
            do_trial(i, isprobe);
        }
    }

    // Don't do anything once all trails are over.
    while( true )
    {
        reset_watchdog( );
        Serial.println( ">>> Good job. All done. Go home and play!" );
        delay( 2000 );
    }
}
