vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
  OUT_SOURCE_PATH
    SOURCE_PATH
  REPO
    richgel999/fpng
  REF
    ${VERSION}
  SHA512
    44c4022c390fffb19e28ea4eb25fb08b828f8b0bf6dfbca6bb08b61775c2851d6ccbb09ebebfd7ce89d9b5d7fcf66e5e1a2a1189d2c0438b4b59ec63ff134f91
)

# 上流のテスト用 CMakeLists.txt を置き換え、ライブラリと Config を生成できる構成にするため上書きする
file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt
    DESTINATION ${SOURCE_PATH})
# find_package 用の設定ファイルテンプレート（fpng-config.cmake.in）も上流ツリーへコピーする
file(COPY ${CMAKE_CURRENT_LIST_DIR}/fpng-config.cmake.in
     DESTINATION ${SOURCE_PATH})

vcpkg_cmake_configure(SOURCE_PATH ${SOURCE_PATH})
vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup()
