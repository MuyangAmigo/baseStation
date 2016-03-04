#General description
Your last project for this course, in a sense, is a wrap-up of the steps taken in the first two projects. Namely, you are expected to implement a full-fledged operational (mini) network that will have the ability to give the end-users the information of what’s going on in the physical reality monitored by the network. Once again you will be building a TinyOS application to run on TelosB motes – however, in addition to the two nodes that notify each other about the events of interest in their locale, now there will be a third node – a dedicated sink that will be attached to the USB port of your (well, mine too) laptop.

As discussed in class, you are more than welcome to join forces between existing teams – i.e., now you can work with teams of up to 4 people (modulo the comment about folks who already had 3 team-members for the 2 nd project – those remain 3...).

#Assignment Specifics
Just like the 2nd project, the assumption for this last project is that you already have the nodes which combine sampling+notification+notification behavior available from Project#2. For this project, the global-sink will forward the received data through a virtual serial port (USB - UART module) and the data will be displayed graphically, along with the indication of its corresponding type (i.e., whether it is a light/temperature) on a window (oscilloscope).

#Hints
You will need to play with the Oscilloscope application (get into '.../apps/Oscilloscope', and do all the 'motelist' + 'make install telosb' +... stuff).
##Other hints:
Now, once the Oscilloscope has been installed on the sources, since the sink node will behave as a “Base Station” – which means: you will need to compile/install the very BaseStation application on the TelosB mote that will serve as a sink and will be hooked to the USB port.

The “raw” way of communicating with the Base Station mote is to simply open the serial port and dump the packets to the screen. To augment this primitive-like manner, you will need to somehow introduce “manners” – which, in turn, implies that you’ll need to incorporate something called “SerialForwarder” – for which, in a separate terminal you will need to launch the communication via:
'''
java net.tinyos.sf.SerialForwarder –comm serial@/dev/ttyUSB0:telosb
'''

Once the SerialForwarder has started running, the last step is to invoke the java application that will actually display the data on the oscilloscope window. For that, you should have a sub-directory '...apps/Oscilloscope/java' in which you need to:
'java net.tinyos.oscope.oscilloscope'

As an almost-last hint: you will only need to fiddle a little bit with the messages format (namely, the application will wait for a buffer of a certain size to be filled in before displaying it). You may want to check:
>http://www.tinyos.net/dist-2.0.0/tinyos-2.x/doc/html/tutorial/lesson4.html
>http://www.tinyos.net/dist-2.0.0/tinyos-2.x/doc/html/tutorial/lesson5.html

#EXTRA CREDIT
You can receive up to 20% extra credit if you “play with the appearance”. Namely, thus far it was assumed that the data-generating nodes were in charge of one value (e.g., either temperature or light intensity). However, it is possible that an application would need dual readings from each node in the network. Hence, for the extra credit portion, you should cater to this possibility. Note that, in general, this is a non-trivial task. However, for small-size networks, one can get by – just “tweak” the messages from a particular node (e.g., Node_i_Temp could be 010 and Node_i_Light could be 011 – just a hint).
