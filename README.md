# sweep_host

A Flutter application designed to support and manage cleaning activities. (プロジェクトの目的をより具体的に記述してください)

## 主な機能

*   **マップ表示**: ごみの場所や清掃活動の範囲を地図上に表示します。 (`lib/pages/map_page`)
*   **投稿機能**: 清掃活動の報告やごみの情報を投稿できます。 (`lib/classes/post.dart`, `lib/widgets/post_item.dart`)
*   **履歴表示**: 過去の清掃活動の履歴を確認できます。 (`lib/pages/history_page`)
*   **分析機能**: 清掃活動のデータを分析し、可視化します。 (`lib/pages/analytics_page.dart`)
*   **ユーザープロファイル**: ユーザー情報を管理します。 (`lib/classes/profile.dart`)

## 使用技術

*   **Flutter**: UIツールキット
*   **Firebase**: バックエンドサービス (認証、データベース、ストレージなど)
*   **Riverpod**: 状態管理
*   **flutter_map**: 地図表示ライブラリ
*   **freezed**: イミュータブルなクラス生成
*   **hooks_riverpod**: Riverpod と Flutter Hooks の連携

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## プロジェクト構造 (概要)

```
sweep_host/
├── android/            # Android固有のコード
├── assets/             # 画像、フォントなどの静的ファイル
│   ├── fonts/
│   └── images/
├── ios/                # iOS固有のコード
├── lib/                # Dartのソースコード
│   ├── classes/        # データモデル (Post, Profile, Hostなど)
│   ├── firebase_options.dart # Firebase設定
│   ├── main.dart       # アプリケーションのエントリーポイント
│   ├── pages/          # 各ページのUIとロジック
│   │   ├── analytics_page.dart
│   │   ├── dashboard_page/
│   │   ├── history_page/
│   │   └── map_page/
│   ├── states/         # Riverpodプロバイダーなどの状態管理関連
│   └── widgets/        # 再利用可能なUIコンポーネント
├── test/               # テストコード
├── web/                # Web固有のコード (Flutter Webの場合)
├── pubspec.yaml        # プロジェクトの依存関係とメタデータ
└── README.md           # このファイル
```

## セットアップと実行

1.  Flutter SDK がインストールされていることを確認してください。
2.  依存関係をインストールします:
    ```bash
    flutter pub get
    ```
3.  アプリケーションを実行します:
    ```bash
    flutter run
    ```

(必要に応じて、Firebaseプロジェクトのセットアップ手順などを追記してください)
