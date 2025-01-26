@echo off

set vlc_execution_path="C:\Program Files\VideoLAN\VLC\vlc.exe"
set output_save_folder="E:\VLC_saved_videos\prod"
set execution_time_in_sec=1800
set device_name="USB Video Device"

:loop

	for /f "tokens=2 delims==." %%a in ('wmic os get localdatetime /value') do set datetime=%%a
	set filename=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%-%datetime:~12,2%.avi
	set output_file=%output_save_folder%\%filename%

	rem only for saving to Hard Disk 
	rem start "VLC Recorder" %vlc_execution_path% dshow:// :dshow-vdev="USB Video Device" --sout file/avi:%output_file% --run-time=%execution_time_in_sec%

	rem --sout-keep option keep open stream connection and conflicts with saving(close) file to filesystem, when we kill task by PID !!!  
	rem start "VLC Recorder" %vlc_execution_path% dshow:// :dshow-vdev=%device_name% :dshow-adev=none --sout "#transcode{vcodec=h264,acodec=mpga,ab=128,channels=2,samplerate=44100,scodec=none}:duplicate{dst=file{dst=%output_file%,no-overwrite},dst=http{mux=ffmpeg{mux=flv},dst=:55555/anyStreamName}}" --no-sout-all --sout-keep --run-time=%execution_time_in_sec%
	start "VLC Recorder" %vlc_execution_path% dshow:// :dshow-vdev=%device_name% :dshow-adev=none --sout "#transcode{vcodec=h264,acodec=mpga,ab=128,channels=2,samplerate=44100,scodec=none}:duplicate{dst=file{dst=%output_file%,no-overwrite},dst=http{mux=ffmpeg{mux=flv},dst=:55555/anyStreamName}}" --no-sout-all --run-time=%execution_time_in_sec%
	echo Wait 2 seconds for start proccess...
	timeout /t 2 >nul

	rem find last created vlc process. Output list default ordering is CreationDate ASC.
	for /f %%a in ('wmic process where "name='vlc.exe'" get ProcessId ^| findstr /r "[0-9]"') do (
	    set vlc_pid=%%a
	)
	echo Last VLC's pid: %vlc_pid%

	echo Wait %execution_time_in_sec% seconds for execution task...
	timeout /t %execution_time_in_sec% >nul

	timeout /t 5 >nul
	echo Close task by PID %vlc_pid%
	taskkill /PID %vlc_pid% /F

	echo Wait 1 seconds for close for closing task...
	timeout /t 1 >nul

goto loop