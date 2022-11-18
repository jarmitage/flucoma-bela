~fluidPitchBelaTest = SynthDef(\fluidPitchBelaTest, { arg out=0;
	var input0;
	var freq0, freq1, freq2, freq3;
	var conf, hasFreq0, hasFreq1;
	var scope0, scope1, scope2, scope3;
	
	input0 = SoundIn.ar(0);//.belaScope(0);
	
	# freq0, hasFreq0 = Pitch.kr(input0);
	# freq1, hasFreq1 = Tartini.kr(input0);
	# freq2, conf = FluidPitch.kr(input0,window:512);
	freq3 = ZeroCrossing.ar(input0);

	scope0 = K2A.ar(freq0/200).belaScope(0);
	scope1 = K2A.ar(freq1/200).belaScope(1);
	scope2 = K2A.ar(freq2/200).belaScope(2);
	scope3 = (freq3/200).belaScope(3);
	
	~output.(input0);
}).play;
