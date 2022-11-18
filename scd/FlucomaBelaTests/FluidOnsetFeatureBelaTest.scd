/*
FluidOnsetFeature.kr \metric options:
0	Energy thresholds on (sum of squares of magnitudes / nBins) (like Onsets power)
1	HFC thresholds on (sum of (squared magnitudes * binNum) / nBins)
2	SpectralFlux thresholds on (difference in magnitude between consecutive frames, half rectified)
3	MKL thresholds on (sum of log of magnitude ratio per bin) (or equivalently, sum of difference of the log magnitude per bin) (like Onsets mkl)
4	IS (WILL PROBABLY BE REMOVED) Itakura - Saito divergence (see literature)
5	Cosine thresholds on (cosine distance between comparison frames)
6	PhaseDev takes the past 2 frames, projects to the current, as anticipated if it was a steady state, then compute the sum of the differences, on which it thresholds (like Onsets phase)
7	WPhaseDev same as PhaseDev, but weighted by the magnitude in order to remove chaos noise floor (like Onsets wphase)
8	ComplexDev same as PhaseDev, but in the complex domain - the anticipated amp is considered steady, and the phase is projected, then a complex subtraction is done with the actual present frame. The sum of magnitudes is used to threshold (like Onsets complex)
9	RComplexDev same as above, but rectified (like Onsets rcomplex)
*/

~fluidOnsetFeatureBelaTest = SynthDef(\fluidOnsetFeatureBelaTest, { arg out=0;
	var input0;
	var out0, out1, out2, out3;
	var scope0, scope1, scope2, scope3;
	
	input0 = SoundIn.ar(0);//.belaScope(0);
	
	// FluidOnsetFeature.kr(in: 0, metric: 0, filterSize: 5, frameDelta: 0, windowSize: 1024, hopSize: -1, fftSize: -1, maxFFTSize: -1)
	out0 = FluidOnsetFeature.kr(input0, 9, filterSize:5, windowSize:512);
	// Coyote.kr(in: 0.0, trackFall: 0.2, slowLag: 0.2, fastLag: 0.01, fastMul: 0.5, thresh: 0.05, minDur: 0.1)
	out1 = Coyote.kr(input0, fastMul: 0.5, thresh: 0.001);
	// Onsets.kr(chain, threshold: 0.5, odftype: 'rcomplex', relaxtime: 1, floor: 0.1, mingap: 10, medianspan: 11, whtype: 1, rawodf: 0)
	out2 = Onsets.kr(FFT(LocalBuf(512), input0), threshold: 0.5, \rcomplex);
	// AttackSlope.kr(input, windowsize: 1024, peakpicksize: 20, leak: 0.999, energythreshold: 0.01, sumthreshold: 20, mingap: 30, numslopesaveraged: 10)
	out3 = AttackSlope.kr(source,peakpicksize:20,sumthreshold:40);

	scope0 = K2A.ar(out0/200).belaScope(0);
	scope1 = K2A.ar(out1/200).belaScope(1);
	scope2 = K2A.ar(out2/200).belaScope(2);
	scope3 = (out3/200).belaScope(3);
	
	~output.(input0);
}).play;
