~fluidAmpFeatureBelaTest = SynthDef(\fluidAmpFeatureBelaTest, { arg out=0;
	var input0;
	var freq0, freq1, freq2, freq3;
	var out0, out1, out2, out3;
	
	input0 = SoundIn.ar(0);//.belaScope(0);
	
	// FluidAmpFeature.ar(in: 0, fastRampUp: 1, fastRampDown: 1, slowRampUp: 100, slowRampDown: 100, floor: -144, highPassFreq: 85)
	out0 = FluidAmpFeature.ar(input0, 100, 100, 44100, 44100, -40);
	// Amplitude.kr(in: 0.0, attackTime: 0.01, releaseTime: 0.01, mul: 1.0, add: 0.0)
	out1 = Amplitude.kr(input0, 0.01, 0.01, 1200, 400);

	scope0 = K2A.ar(out0/200).belaScope(0);
	scope1 = K2A.ar(out1/200).belaScope(1);
	scope2 = K2A.ar(out2/200).belaScope(2);
	scope3 = (out3/200).belaScope(3);
	
	~output.(input0);
}).play;
