# Video Streaming

## AWS

- Elastic Transcoder replaced with MediaConvert
- Add to IAM role, MediaConvert
- Select CMAF: Create a fragmented MP4 ABR stack for streaming to both Apple HLS or MPEG-DASH compatible players.

- - Other options:
- - - File group Create unpackaged outputs, such as MPEG-4 or QuickTime files.
- - - Apple HLS Create a stack of outputs for adaptive bitrate streaming to Apple players.
- - - DASH ISO Create a stack of outputs for adaptive bitrate streaming to MPEG-DASH players.
- - - Microsoft Smooth StreamingPro Create a stack of outputs for adaptive bitrate streaming to Microsoft players.


- Two output subsettings for CMAF: AV1 and AAC. I left both with default settings.
- Output Preset I set to `System-Avc_16x9_270p_14_99fps_400kbps`
- Aspect Ratios: `1920x1080 and you set Height to 720, your output will be 1280x720`
- Bitrate: `16200` in this case
