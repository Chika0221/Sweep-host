# Sweep

住民参加型ゴミ拾いアプリとスマートゴミ箱で、街のポイ捨て問題を解決するプロジェクトです。主な目的はHOSTへのゴミの落ちている地点の可視化。それによりゴミの回収の最適化することにあります。

## 概要

「Sweep」は、スマートフォンアプリとスマートゴミ箱「SwapBox」を連携させることで、市民が参加しやすく、継続しやすい新しいゴミ拾いの形を提案するプロジェクトです。 大津市のポイ捨て問題という社会課題を、テクノロジーの力で解決することを目指しています。

## 背景

大津市では、ポイ捨てによるごみが問題となっています。 調査によると、清掃活動に参加したくても「参加方法がわからない」「一人では参加しづらい」「忙しくて時間がない」といった理由で、参加できていない人が多くいることがわかっています。 また、「近くにゴミ箱がない」「ポイ捨てに対する意識が低い」といった点も、ポイ捨ての原因として挙げられています。

これらの課題を解決するため、私たちは楽しみながらゴミ拾いに参加できる仕組みとして、住民参加型ゴミ拾いアプリ「Sweep」とスマートゴミ箱「SwapBox」を開発しました。

## 機能

### スマートフォンアプリ「Sweep」
[Sweepのリポジトリはこちら](https://github.com/Chika0221/Sweep)

「Sweep」は、ゴミ拾いをより楽しく、身近にするためのアプリケーションです。

| 機能 | 説明 |
| :--- | :--- |
| **ユーザー認証** | GoogleまたはAppleアカウントで簡単にログインできます。 |
| **ゴミ情報の投稿** | ゴミを見つけたら、写真とコメントを付けて、その場所を投稿できます。 |
| **マップ機能** | 投稿されたゴミの位置や、ゴミ箱の設置場所を地図上で確認できます。 |
| **タイムライン** | 他のユーザーの投稿をリアルタイムで見ることができます。 |
| **ポイントシステム** | ゴミ拾いやゴミ箱の利用でポイントが貯まります。 |
| **ポイント交換** | 貯まったポイントは、地域の魅力が詰まったオリジナルキーホルダーと交換できます。 |

### PC向けのWEBアプリ 「Sweep-Host」
**このリポジトリです。**

「Sweep-Host」は**Sweep**で収集したでデータをホスト側にグラフや表などで提供するWEBアプリです。

| 機能 | 説明 |
| :--- | :--- |
| **ユーザー認証** | メールアドレスを用いてHOSTアカウントを作成 |
| **ゴミ情報の投稿の閲覧** | 投稿ユーザーや正確な投稿時間などユーザーでは取得できない情報を取得可能
| **マップ機能** | 投稿されたゴミの位置や、ゴミ箱の設置場所を地図上で確認できます。またゴミの分布をヒートマップで表示 |



### スマートゴミ箱「SwapBox」

「SwapBox」は、IoT技術を活用したスマートなゴミ箱です。

* **ゴミの重量測定:** センサーがゴミの重さを自動で測定します。
* **QRコード連携:** アプリのQRコードをかざすことで、ユーザーを認識し、ポイントを付与します。
* **データ送信:** 収集したデータ（ユーザー情報、ゴミの重量）は、自動でFirebaseに送信されます。

## 技術スタック

### アプリケーション

| 技術 | 目的 |
| :--- | :--- |
| **Flutter** | iOS/Androidのクロスプラットフォーム開発を高速に行うために採用しました。 |
| **Firebase** | データベース、画像ストレージ、ユーザー認証など、バックエンド機能全般で活用しています。 |

### スマートゴミ箱

| 技術 | 目的 |
| :--- | :--- |
| **M5Stack** | プロトタイプの中心的な役割を担っています。 |
| **HX711** | ゴミの重量を精密に測定するために使用しています。 |
| **QRコードスキャナー** | ユーザーのQRコードを高速かつ正確に読み取ります。 |

### WEBアプリ

| 技術 | 目的 |
| :--- | :--- |
| **Flutter** | FlutterWebを使用
| **Firebase** | データベース、画像ストレージ、ユーザー認証など、バックエンド機能全般で活用しています。 |