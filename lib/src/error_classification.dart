/// Media errors which `mpv` has already recovered from on its own.
///
/// When decoding a damaged packet fails, `mpv` logs an `error`-level message
/// (e.g. `Error decoding audio.`) and then simply drops that packet and keeps
/// playing the rest of the file. `media_kit` forwards those log messages to
/// [Player.stream.error], so they must not be treated as fatal here: marking
/// the player as `idle` would make `just_audio` tear down the platform player
/// and the audio would stop for the remainder of the track.
library;

final List<RegExp> _recoverableMediaErrorPatterns = <RegExp>[
  RegExp(r'^Error decoding audio', caseSensitive: false),
  RegExp(r'^Error decoding video', caseSensitive: false),
];

/// Whether [message] is a recoverable media error reported by `mpv`.
bool isRecoverableMediaError(String message) {
  final String normalized = message.trim();
  if (normalized.isEmpty) {
    return false;
  }
  return _recoverableMediaErrorPatterns
      .any((RegExp pattern) => pattern.hasMatch(normalized));
}
