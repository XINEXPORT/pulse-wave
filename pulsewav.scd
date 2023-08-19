(
SynthDef("pulsewav", {arg out = 0, freq=400, pan = 0, rate=2, amp=0.2, gate=1, mul = 1;
	var acco, snd;
	acco = Env.adsr(
		attackTime:0.2,
		decayTime:0.8,
		sustainLevel:0.3,
		releaseTime:0.5,
		peakLevel:2,
		curve:-4.0,
		bias:0).kr(gate: gate, doneAction:2);
	snd = LPF.ar(
		in: Pulse.ar(freq: [freq]));
	snd = snd*acco;
	snd = Mix.ar(snd);
	snd = BPF.ar(
		in: Pulse.ar(freq: [freq]));
	Out.ar([0,1],Pan2.ar (snd, pan, amp));
}).add;
)


(
SynthDef("bass", {arg out = 0, freq=80, pan = 0, rate=2, amp=0.5, gate=1, mul = 1;
	var acco, snd;
	acco = Env.adsr(
		attackTime:0.2,
		decayTime:0.8,
		sustainLevel:0.3,
		releaseTime:0.5,
		peakLevel:2,
		curve:-4.0,
		bias:0).kr(gate: gate, doneAction:2);
	snd = LPF.ar(
		in: Pulse.ar(freq: freq,
			width:1,
			mul: mul));
	snd = snd*acco;
	snd = Mix.ar(snd);
	snd = BPF.ar(
		in: Pulse.ar(freq: [freq]));
	acco = Env.linen(
		attackTime:0.1,
		sustainTime:1,
		releaseTime:0.4,
		level: 0.1,
		curve:-0.4);
	Out.ar([0,1],Pan2.ar (snd, pan, amp));
}).add;
)


(
Synth(\bass);
)


(
a =
TempoClock (60/60);
Pbind(
	\scale, Scale.harmonicMajor,
	\instrument, \pulsewav,
	\degree, Pseq([0,3,5,7,9,12], inf),
	\dur, 0.5,
	\mul, 2,
	\amp, 0.2,
	\legato, 2,
	\ctranspose, 0.8
).trace.play;
)
4.wait;
(
b =
Pbind(
	TempoClock (60/60);
	\scale, Scale.harmonicMajor,
	\instrument, \bass,
	\freq, Pseq([200,Rest(300),400,Rest (500),600,700],inf),
	\dur, Pseq([0.2, 0.3, 0.2, 0.4, 0.6, 0.7], inf),
	\mul, 2,
	\amp, 0.4,
	\legato, 0.8,
	\ctranspose, 0.3
).trace.play;
)
b.


(
Pbind(
	TempoClock (120/60);
	\scale, Scale.dorian,
	\instrument, \eerie,
	\degree, Pwhite (-10, 0,inf),
	\dur, 2 ,
	\mul, 1,
	\amp, 0.4,
	\legato, 0.5,
	\ctranspose, 0.1
).play;
)





{SinOsc.ar ([100,200,300])}.scope.play;
