// based on https://github.com/Intelligent-Instruments-Lab/proto-langspil

(
n = 0;

this.executeFile("FluidAmpFeatureBelaTest.scd"); 	~fluidAmpFeatureBelaTest.run(false);
this.executeFile("FluidOnsetFeatureBelaTest.scd"); 	~fluidOnsetFeatureBelaTest.run(false);
this.executeFile("FluidPitchBelaTest.scd"); 		~fluidPitchBelaTest.run(false);
this.executeFile("FluidSpectralShapeBelaTest.scd");	~fluidSpectralShapeBelaTest.run(false);

~synths = [
	~fluidAmpFeatureBelaTest,
	~fluidOnsetFeatureBelaTest,
	~fluidPitchBelaTest,
	~fluidSpectralShapeBelaTest
];
	
SynthDef(\click, {arg num_clicks;
	var signal = Impulse.ar(8);
	var env = EnvGen.kr(
		Env.perc(0, (num_clicks-0.5)/8, curve:\hold),
		doneAction: Done.freeSelf,
		gate: Impulse.kr(0));
	~output.(signal)
}).add;

~button_synth = SynthDef(\langspil, {
	var button = DigitalIn.kr(0);
	var trig = Trig1.kr(button, 0.2);
	// button.poll(5);
	SendReply.kr(trig, '/button');
}).play;

OSCdef(\button_def, {
	n = n%3 + 1;
	n.postln;
    Synth(\click, [\num_clicks, n]);
    ~synths.do{arg s; s!?(_.run(false))};
    case
    {n==1}{~fluidAmpFeatureBelaTest!?(_.run)}
    {n==2}{~fluidOnsetFeatureBelaTest!?(_.run)}
    {n==3}{~fluidPitchBelaTest!?(_.run)}
	{n==3}{~fluidSpectralShapeBelaTest!?(_.run)}
}, "/button");

)
