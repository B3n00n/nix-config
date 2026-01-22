# Audio configuration using PipeWire
{ ... }:

{
  # PipeWire audio server (modern replacement for PulseAudio and JACK)
  services.pipewire = {
    enable = true;

    # Enable PulseAudio compatibility layer
    pulse.enable = true;

    # Enable ALSA support
    alsa = {
      enable = true;
      support32Bit = true;  # Required for 32-bit applications
    };
  };

  # Enable rtkit for real-time audio scheduling
  # This prevents audio dropouts and improves latency
  security.rtkit.enable = true;
}
