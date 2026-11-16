import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio_media_kit/src/error_classification.dart';

void main() {
  group('isRecoverableMediaError', () {
    test('treats mpv decode errors as recoverable', () {
      expect(isRecoverableMediaError('Error decoding audio.'), isTrue);
      expect(isRecoverableMediaError('Error decoding audio'), isTrue);
      expect(isRecoverableMediaError('error decoding audio.'), isTrue);
      expect(isRecoverableMediaError('Error decoding video.'), isTrue);
      expect(isRecoverableMediaError('  Error decoding audio.  '), isTrue);
    });

    test('keeps fatal playback errors fatal', () {
      expect(
        isRecoverableMediaError(
          "Failed to open file:///C:/music/broken.mp3.",
        ),
        isFalse,
      );
      expect(
        isRecoverableMediaError('Could not open/initialize audio device.'),
        isFalse,
      );
      expect(isRecoverableMediaError('Failed to recognize file format.'), isFalse);
      expect(isRecoverableMediaError(''), isFalse);
      expect(isRecoverableMediaError('   '), isFalse);
    });
  });
}
