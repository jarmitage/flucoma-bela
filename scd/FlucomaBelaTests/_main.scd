// based on https://github.com/Intelligent-Instruments-Lab/proto-langspil

s = Server.default;

s.options.numAnalogInChannels = 8; // can be 2, 4 or 8
s.options.numAnalogOutChannels = 2; // can be 2, 4 or 8
s.options.maxLogins = 4; // should match the settings on the remote sclang
s.options.bindAddress = "0.0.0.0"; // allow anyone on the network connect to this server

s.options.numDigitalChannels = 16;
s.options.pgaGainLeft = 10;     // sets the gain for the left audio input to 4 dB
s.options.pgaGainRight = 10;    // sets the gain for the left audio input to 5 dB
s.options.headphoneLevel = -6; // sets the headphone level to -6 dB
s.options.speakerMuted = 0;    // enable the speaker amp
s.options.dacLevel = 0;       // sets the gain of the dac to 0 dB
s.options.adcLevel = 0;       // sets the gain of the adc to 0 dB
s.options.numMultiplexChannels = 0; // do not enable multiplexer channels

s.options.blockSize = 256;
s.options.numInputBusChannels = 3; // Use only the L/R audio channels
s.options.numOutputBusChannels = 2; // Use only the L/R audio channels
s.options.belaMaxScopeChannels = 4; // allow to send some channels to the Bela scope

s.options.memSize = 8192 * 4; // the default is 8192 which is quite little

~output_bus = 0;
~output = {arg signal;
	Out.ar(~output_bus, [signal, 0-signal])
};

s.waitForBoot({this.executeFile("FlucomaBelaTests.scd")});
