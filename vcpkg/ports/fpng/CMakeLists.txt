cmake_minimum_required(VERSION 3.0)
project(fpng LANGUAGES CXX)

# fpng を静的ライブラリとしてビルドするように指定する。
# 今回は fpng.cpp だけが必要なので、それだけをソースとして追加する。
add_library(fpng STATIC)
target_sources(fpng PRIVATE src/fpng.cpp)

# インクルードディレクトリを指定
# BUILD_INTERFACE: ビルド時に使うディレクトリは src を指定する。
# - これは fpng の各種ヘッダーファイルが元リポジトリの src にあるため。
# - ref: https://github.com/richgel999/fpng/tree/main
# INSTALL_INTERFACE: ライブラリユーザー側は include/ を使うように指定する。
target_include_directories(fpng INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
                                          $<INSTALL_INTERFACE:include>)
# Debug ビルド用のライブラリには "d" を末尾に追加する。
set_target_properties(fpng PROPERTIES DEBUG_POSTFIX d)
target_compile_features(fpng PRIVATE cxx_std_11)

# インストール先のディレクトリを取得するために GNUInstallDirs モジュールを読み込む。
include(GNUInstallDirs)

# 静的ライブラリをインストール時にライブラリディレクトリ（${CMAKE_INSTALL_LIBDIR}）へ配置する。
install(
  TARGETS fpng
  EXPORT fpng-targets
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

# ヘッダーファイルをインストールディレクトリ内の include へコピーする。
install(FILES src/fpng.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# ビルドツリーの情報 `fpng-targets` を使って、ユーザー側が利用できるように `fpng-config.cmake` を生成する。
include(CMakePackageConfigHelpers)
configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/fpng-config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/fpng-config.cmake
  INSTALL_DESTINATION
    ${CMAKE_INSTALL_DATADIR}/fpng
)
install(
  FILES ${CMAKE_CURRENT_BINARY_DIR}/fpng-config.cmake
  DESTINATION ${CMAKE_INSTALL_DATADIR}/fpng
)

# ライブラリユーザーが `find_package()` で利用できるようにエクスポート設定をインストールする。
install(
  EXPORT fpng-targets
  DESTINATION ${CMAKE_INSTALL_DATADIR}/fpng
  NAMESPACE fpng::
)
