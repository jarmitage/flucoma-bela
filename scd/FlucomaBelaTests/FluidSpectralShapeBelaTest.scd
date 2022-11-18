~fluidSpectralShapeBelaTest = SynthDef(\fluidSpectralShapeBelaTest, { arg out=0;
	var input0, chain;
	var flatn0, flatn1, zc;
	var scope0, scope1, scope2, scope3;
	
	input0 = SoundIn.ar(0);
	chain = FFT(LocalBuf(2048), input0);
	
	flatn0 = SpecFlatness.kr(chain) ;  // 0= sinoid to 1 = noise
	flatn1 = FluidSpectralShape.kr(input0,[\flatness],unit:1,power:1).linlin(-250,0,0,1); // converted to 0= sinoid to 1 = noise
	zc = ZeroCrossing.ar(input0);

	//posting on sc
	scope0 = flatn0.poll(label:"Flatness");
	scope1 = flatn1[0].poll(label:"fluidflatn");
	0.poll(label:"---------------------------");
	
	//posting on bela
	//scope0 = K2A.ar(flatn0/200).belaScope(0);
	//scope1 = K2A.ar(flatn1[1]).belaScope(1);
	//scope3 = (zc/200).belaScope(2);
	
	Out.ar(out, input0);
}).play;
