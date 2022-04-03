set :bpm, 20
use_bpm get :bpm

chords = :minor7

with_fx :reverb, room: 1.0, mix: 0.8, amp: 0.3 do
  live_loop :main do
    use_synth :zawa
    use_synth_defaults amp: (rrand 0.5, 0.7), range: 12, phase: 0.4, wave: 3,
      attack: 0.5, release: 4.0, res: 0.0, cutoff: 75
    
    notes = shuffle (chord :F3, chords)
    play notes[0], pan: 0.2
    play notes[1], pan: -0.2, invert_wave: 1
    sleep 2.0
    sleep 2.0 if one_in(5)
  end
  
  live_loop :main2 do
    play :F4, pan: (rrand -0.1, 0.1), amp: 0.4
    sleep 1.0
  end
  
  live_loop :noise do
    synth :bnoise, cutoff: (rrand 70, 90),
      sustain: 2.0, release: 2.0, attack: 2.0,
      amp: 0.3, pan: (rrand -0.2, 0.2)
    sleep 2.0
  end
end

with_fx :octaver, mix: 0.3, super_amp: 0.5 do
  with_fx :reverb, room: 1.0, mix: 0.8 do
    live_loop :pianoSupport do
      use_synth :dark_ambience
      use_synth_defaults release: 2.0, ring: 1
      play (choose chord :F4, chords), pan: -0.4
      play (choose chord :F4, chords), pan: 0.4
      sleep 2 * [0.5, 1.0].choose
    end
    
    live_loop :pianoMain do
      base = :F5
      use_synth :dark_ambience
      use_synth_defaults res: 0.9, noise: 1
      play (choose chord base, chords), pan: -0.2
      play (choose chord base, chords), pan: 0.2
      sleep 2 * [0.125, 0.125, 0.25, 0.25, 0.5].choose
    end
  end
end
