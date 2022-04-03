set :bpm, 20
use_bpm get :bpm

chords = :minor7

with_fx :reverb, room: 1.0, mix: 1, damp: 1 do
  live_loop :main do
    use_synth :zawa
    use_synth_defaults amp: (rrand 0.3, 0.4), range: 12, phase: 0.4, wave: 3,
      attack: 0.5, release: 4.0, res: 0.0, cutoff: 75
    
    notes = shuffle (chord :F2, chords)
    play notes[0], pan: 0.2
    play notes[1], pan: -0.2, invert_wave: 1
    sleep 2.0
    sleep 2.0 if one_in(5)
  end
  
  live_loop :main2 do
    play :F3, pan: (rrand -0.4, 0.4), amp: 0.4
    sleep 1.0
  end
  
  live_loop :bg_melody do
    synth :mod_sine, note: (choose chord :F2, chords),
      mod_range: 3, mod_phase: (rrand 0.5, 1.0), mod_wave: 3,
      attack: 1.0, sustain: 1.0, release: 1.0,
      pan: (rrand -0.1, 0.1), amp: 0.7
    sleep 1.0
  end
  
  live_loop :noise do
    synth :bnoise, cutoff: (rrand 70, 90),
      sustain: 2.0, release: 2.0, attack: 2.0,
      amp: 0.5, pan: (rrand -0.2, 0.2)
    sleep 2.0
  end
end

live_loop :noise2 do
  synth :bnoise, cutoff: 100,
    sustain: 2.0, release: 0.0, attack: 0.0,
    amp: 0.2, pan: 0.0
  sleep 2.0
end

with_fx :reverb, room: 1.0, mix: 1 do
  live_loop :vinyl do
    sample :vinyl_hiss, amp: 2
    sample :vinyl_hiss, rate: -1, amp: 2
    sleep sample_duration :vinyl_hiss
  end
end