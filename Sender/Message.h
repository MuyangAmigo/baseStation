#ifndef MESSAGE_H
#define MESSAGE_H

typedef nx_struct ProjB_Msg{
  nx_uint16_t Temperature;
  nx_uint16_t Light;
} ProjB_Msg;


enum {AM_PROJB_MSG = 6};

#endif

