# Binaries branch name: ffmpeg/3.4_20200907
# Binaries were created for OpenCV: 03bee14372f5537daa56c62e771ec16181ca1f98
ocv_update(FFMPEG_BINARIES_COMMIT "2a96257b743695a47f8012aab1ffb995a1dee8b4")
ocv_update(FFMPEG_FILE_HASH_BIN32 "5e68a3ff82f43ac6524e50e448a34c9c")
ocv_update(FFMPEG_FILE_HASH_BIN64 "205db629d893e7d4865fd1459807ff47")
ocv_update(FFMPEG_FILE_HASH_CMAKE "3b90f67f4b429e77d3da36698cef700c")

function(download_win_ffmpeg script_var)
  set(${script_var} "" PARENT_SCOPE)

  set(ids BIN32 BIN64 CMAKE)
  set(name_BIN32 "opencv_ffmpeg.dll")
  set(name_BIN64 "opencv_ffmpeg_64.dll")
  set(name_CMAKE "ffmpeg_version.cmake")

  set(FFMPEG_DOWNLOAD_DIR "${OpenCV_BINARY_DIR}/3rdparty/ffmpeg")

  set(status TRUE)
  foreach(id ${ids})
    ocv_download(FILENAME ${name_${id}}
               HASH ${FFMPEG_FILE_HASH_${id}}
               URL
                 "$ENV{OPENCV_FFMPEG_URL}"
                 "${OPENCV_FFMPEG_URL}"
                 "https://raw.githubusercontent.com/opencv/opencv_3rdparty/${FFMPEG_BINARIES_COMMIT}/ffmpeg/"
               DESTINATION_DIR ${FFMPEG_DOWNLOAD_DIR}
               ID FFMPEG
               RELATIVE_URL
               STATUS res)
    if(NOT res)
      set(status FALSE)
    endif()
  endforeach()
  if(status)
    set(${script_var} "${FFMPEG_DOWNLOAD_DIR}/ffmpeg_version.cmake" PARENT_SCOPE)
  endif()
endfunction()

if(OPENCV_INSTALL_FFMPEG_DOWNLOAD_SCRIPT)
  configure_file("${CMAKE_CURRENT_LIST_DIR}/ffmpeg-download.ps1.in" "${CMAKE_BINARY_DIR}/win-install/ffmpeg-download.ps1" @ONLY)
  install(FILES "${CMAKE_BINARY_DIR}/win-install/ffmpeg-download.ps1" DESTINATION "." COMPONENT libs)
endif()

ocv_install_3rdparty_licenses(ffmpeg license.txt readme.txt)
