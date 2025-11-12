# vcpkg + CMake サンプル (Windows)

このリポジトリは、CMake Presets と vcpkg (マニフェストモード) で外部ライブラリを取得・ビルドする最小サンプルです。  
本サンプルは [レイトレ合宿 11](https://sites.google.com/view/rtcamp11) で発表した [セミナー資料](https://www.docswell.com/s/Pheema/57482J-2025-11-16-235833) のサンプルプロジェクトです。

## 想定環境

- Visual Studio 2022
- vcpkg (`VCPKG_ROOT` が設定されていること)
  - コマンドプロンプト: `echo %VCPKG_ROOT%` を実行して確認してください
  - PowerShell: `echo $env:VCPKG_ROOT` を実行して確認してください
- CMake 3.21 以降
  - `cmake --version` でバージョンを確認してください

## 実行ファイルのビルド手順

1. 構成例: /MD (動的 CRT), x64-windows-static-md
   - `cmake --preset x64-win-static-md`
1. ビルド (Release 例)
   - `cmake --build --preset x64-win-static-md --config Release`

## プリセットの種類

- `x64-win-md`: 動的 CRT (/MD)
- `x64-win-mt`: 静的 CRT (/MT)
- `x64-win-static-md`: 動的 CRT + 静的リンクライブラリ

プリセットの定義は [`CMakePresets.json`](CMakePresets.json) を参照してください。

## overlay port のサンプル

- vcpkg に登録されていないライブラリ (例: [fpng](https://github.com/richgel999/fpng)) を利用するためのサンプルを `vcpkg/ports/fpng` に用意しています。
- `find_package(fpng CONFIG REQUIRED)` で `fpng::fpng` をリンクできます。
