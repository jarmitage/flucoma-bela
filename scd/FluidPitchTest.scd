s = Server.default;

s.options.numAnalogInChannels = 2; // can only be 2, 4 or 8
s.options.numAnalogOutChannels = 2;
s.options.numDigitalChannels = 16;
s.options.maxLogins = 4;  	   // set max number of clients
s.options.bindAddress = "0.0.0.0"; // allow anyone on the network connect to this server

s.options.blockSize = 256;
s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;

s.waitForBoot{
	SynthDef('FluidPitchTest', {
		var freq, conf;
		var in = SinOsc.ar(440);//SoundIn.ar(0);
		# freq, conf = FluidPitch.kr(in,window:1024);
		freq.poll(0.5);
		conf.poll(0.5);
	}).add;

	s.sync;

	f = Synth('FluidPitchTest');
};

ServerQuit.add({ 0.exit }); // quit if the button is pressed