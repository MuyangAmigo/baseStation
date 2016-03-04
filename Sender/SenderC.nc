#include "Timer.h"
#include "Message.h"
#include "stdint.h"

#define TIMER_PERIOD 2000 //temp



module SenderC {
  uses interface Boot;
  uses interface Timer<TMilli> as Timer;
  uses interface Timer<TMilli> as Timer1;
  uses interface Timer<TMilli> as Timer2;
  uses interface Leds;
  uses interface Read<uint16_t> as ReadT;
  uses interface Read<uint16_t> as ReadL;
  uses interface Packet;
  uses interface AMPacket;
  uses interface AMSend;
  uses interface SplitControl as RadioControl;
}

implementation {
  bool busy;
  message_t pkt;

  uint8_t S_temperature;
  uint16_t S_light;

  event void Boot.booted() {
    call Timer1.startPeriodic(2000);
    call Timer2.startPeriodic(1000);

    busy = FALSE;
    call RadioControl.start();
  }

  event void RadioControl.startDone(error_t err) {
   if (err == SUCCESS) {
     call Timer.startPeriodic(TIMER_PERIOD);
   }
   else {
     call RadioControl.start();
   }
 }

  event void RadioControl.stopDone(error_t err) {}

  event void Timer.fired() {
    if (!busy) {

      ProjB_Msg* sndPayload = (ProjB_Msg*)(call Packet.getPayload(&pkt, sizeof (ProjB_Msg)));

      sndPayload -> Temperature = S_temperature;
      sndPayload -> Light = S_light;

      if (call AMSend.send(AM_BROADCAST_ADDR, &pkt, sizeof(ProjB_Msg)) == SUCCESS) {
        busy = TRUE;
      }
  } 
  }

  event void Timer1.fired() {
    call ReadT.read();
  }

  event void Timer2.fired() {
    call ReadL.read();
  }

  event void ReadT.readDone(error_t result, uint16_t val) {

      if (result == SUCCESS){
        if (val > 0x0055) {
          call Leds.led1On();
        }
        else {
          call Leds.led1Off();
        }

        if (busy == FALSE) {
          S_temperature = val;
        }
      }
  }

  event void ReadL.readDone(error_t result, uint16_t val) {

      if (result == SUCCESS){
        if (val < 0x0080) {
          call Leds.led2On();
        }
        else {
          call Leds.led2Off();
        }

        if (busy == FALSE) {
          S_light = val;
        }
      }

  }

  event void AMSend.sendDone(message_t* msg, error_t err) {

  }

}
