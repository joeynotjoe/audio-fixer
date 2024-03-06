#!/bin/bash

PATH="/opt/homebrew/bin:/usr/local/bin:${PATH}"
FFMPEG_LOG_LEVEL="-loglevel quiet -stats" # Default log level

show_help() {
    cat <<EOF
Usage: ${0##*/} [OPTION]... [FILE]...
Convert video files by copying the video stream and converting the audio stream to AAC with a bitrate of 160kbps. Outputs the file with '_converted' appended before the file extension.

    --folder, -F    Process all video files within the specified folder.
    --help          Display this help and exit.
    --debug         Enable verbose logging for FFmpeg commands.

Examples:
    ${0##*/} video.mp4                    Process a single file.
    ${0##*/} video1.mp4 video2.mp4        Process multiple specified files.
    ${0##*/} --folder /path/to/folder     Process all files in the specified folder.
    ${0##*/} -F /path/to/folder           Same as --folder.
EOF
}

convert_file() {
    local input_file="$1"
    local start_time=$(date +%s)

    local output_file="${input_file%.*}_converted.mp4"

    echo "🧪 Processing: $input_file"

    # Corrected FFmpeg command
    if ffmpeg -hide_banner -y -i "$input_file" -c:v copy -c:a aac -b:a 160k $FFMPEG_LOG_LEVEL "$output_file"; then
        local end_time=$(date +%s)
        local elapsed=$((end_time - start_time))
        echo "✅ Encoding completed in $elapsed seconds for $input_file"

        local filename_only=$(basename "$input_file")
        osascript -e "display notification \"Encoding completed in $elapsed seconds\" with title \"Encoding Finished\" subtitle \"$filename_only converted\""
    else
        echo "⚠️ Error processing $input_file"
    fi
}

# Process flags
while :; do
    case $1 in
    -h | --help)
        show_help
        exit
        ;;
    --folder | -F)
        FOLDER_MODE=1
        FOLDER_PATH="$2"
        shift
        ;;
    --debug)
        DEBUG=1
        FFMPEG_LOG_LEVEL="" # Enable verbose logging for debugging
        ;;
    --) # End of all options.
        shift
        break
        ;;
    -*)
        echo "🚫 Unknown option: $1" >&2
        exit 1
        ;;
    *) # No more options.
        break
        ;;
    esac
    shift
done

if [ "$FOLDER_MODE" -eq 1 ]; then
    if [ -z "$FOLDER_PATH" ]; then
        echo "📁 It looks like you forgot to specify a folder path."
        exit 1
    fi

    if [ ! -d "$FOLDER_PATH" ]; then
        echo "📁 The specified folder does not exist: $FOLDER_PATH"
        exit 1
    fi

    for file in "$FOLDER_PATH"/*; do
        [[ -f $file ]] && convert_file "$file"
    done
else
    for file in "$@"; do
        convert_file "$file"
    done
fi
