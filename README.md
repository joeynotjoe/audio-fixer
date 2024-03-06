# audio-fixer

The `audio-fixer.sh` script is designed to process video files by copying the video stream (leaving them untouched) and converting the audio stream to 160kbps AAC. It maintains the original filename but appends `_converted` before the `.mp4` extension. The script can process individual files, multiple files, or all files within a specified directory. It logs the encoding duration and displays a notification upon completion.

## Features

- **Copy Video Stream:** The video stream of the input file is copied directly without re-encoding.
- **Convert Audio to AAC:** The audio stream is converted to AAC with a bitrate of 160kbps.
- **Filename Management:** The output file retains the original filename with `_converted` appended before the `.mp4` extension.
- **Batch Processing:** Capable of processing multiple files or all files within a specified directory.
- **Performance Logging:** Logs how long each file's encoding takes.
- **Completion Notification:** Displays a macOS notification with the encoding time upon completion.

## Usage

To use the `audio-fixer.sh` script, navigate to the directory where the script is saved and run it from the command line. The script accepts individual file paths or a directory path with the appropriate flags.

```bash
./audio-fixer.sh [OPTION]... [FILE]...
```

## Options

--help: Display detailed usage instructions and exit. Use this option if you need guidance or want to understand more about what the script can do.

--folder, -F: Specify this option followed by a path to a folder to process all video files within the specified folder. This is useful for batch processing multiple files at once.

## Examples

To process a single file:

```bash
./audio-fixer.sh video.mp4
```

To process multiple specified files:

```
bash
./audio-fixer.sh video1.mp4 video2.mp4
```

To process all files in a specified folder:

```bash
./audio-fixer.sh --folder /path/to/folder
```

or alternatively, using the -F flag:

```bash
./audio-fixer.sh -F /path/to/folder
```

The script processes each specified video file by copying the video stream and converting the audio stream to 160kbps AAC. It outputs the processed file(s) in the same location as the input file(s), appending \_converted before the file extension. A macOS notification is displayed upon the completion of each file, indicating the encoding duration.
