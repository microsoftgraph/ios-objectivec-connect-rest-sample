# Microsoft Graph を使った iOS 用 Office 365 Connect サンプル

各 iOS アプリで Office 365 のサービスとデータの操作を開始するため、最初に Office 365 に接続する必要があります。このサンプルでは、Microsoft Graph (以前は Office 365 統合 API と呼ばれていた) を介して、1 つの API に接続して呼び出す方法を示します。

> メモ: このサンプルをより迅速に実行するため、「[Office 365 API を使う](http://dev.office.com/getting-started/office365apis?platform=option-ios#setup)」ページに記載された登録の簡略化をお試しください。
 
## 前提条件
* Apple 社の [Xcode](https://developer.apple.com/xcode/downloads/)
* 依存関係マネージャーとしての [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) のインストール。
* Office 365 アカウント。Office 365 アプリのビルドを開始するために必要なリソースを含む [Office 365 Developer サブスクリプション](https://aka.ms/devprogramsignup)にサインアップできます。

    > メモ: サブスクリプションをすでにお持ちの場合、上記のリンクをクリックすると、「*申し訳ございません。現在のアカウントに追加できません*」というメッセージが表示されるページに移動します。その場合は、現在使っている Office 365 サブスクリプションのアカウントをご利用いただけます。
* アプリケーションを登録する Microsoft Azure テナント。Azure Active Directory (AD) は、アプリケーションでの認証と承認に使う ID サービスを提供します。ここでは、試用版サブスクリプションを取得できます。 [Microsoft Azure](https://account.windowsazure.com/SignUp)。

     > 重要: Azure サブスクリプションが Office 365 テナントにバインドされていることを確認する必要もあります。確認する方法については、Active Directory チームのブログ投稿「[複数の Windows Azure Active Directory を作成して管理する](http://blogs.technet.com/b/ad/archive/2013/11/08/creating-and-managing-multiple-windows-azure-active-directories.aspx)」をご覧ください。「**新しいディレクトリを追加する**」セクションで、この方法を説明しています。また、詳しくは、「[Office 365 開発環境のセットアップ](https://msdn.microsoft.com/office/office365/howto/setup-development-environment#bk_CreateAzureSubscription)」と「**Office 365 アカウントを Azure AD と関連付けて、アプリを作成して管理する**」のセクションをご覧ください。
      
* Azure に登録されたアプリケーションのクライアント ID とリダイレクト URI の値。このサンプル アプリケーションには、**Microsoft Graph** の**ユーザーとしてメールを送信する**アクセス許可を付与する必要があります。登録を作成するには、「[Office 365 API にアクセスできるようにアプリを Azure AD に手動で登録する](https://msdn.microsoft.com/en-us/office/office365/howto/add-common-consent-manually)」の「**Azure 管理ポータルにネイティブ アプリを登録する**」と、適切なアクセス許可を付与するためのサンプル Wiki の「[適切なアクセス許可を付与する](https://github.com/OfficeDev/O365-iOS-Microsoft-Graph-Connect/wiki/Grant-permissions-to-the-Connect-application-in-Azure)」をご覧ください。


       
## Xcode でこのサンプルを実行する

1. このリポジトリの複製を作成する
2. CocoaPods を使って、Active Directory 認証ライブラリ (ADAL) iOS の依存関係をインポートします。
        
	     pod 'ADALiOS', '= 1.2.4'

 このサンプル アプリには、プロジェクトに ADAL コンポーネント (pods) を取り込む podfile がすでに含まれています。**ターミナル**からプロジェクトに移動して次を実行するだけです。
        
        pod install
        
   詳しくは、[その他の技術情報](#AdditionalResources)の「**CocoaPods を使う**」をご覧ください。
  
3. **O365-iOS-Microsoft-Graph-Connect.xcworkspace** を開きます。
4. **ConnectViewController.m** を開きます。**ClientID** と **RedirectUri** の各値がファイルの一番上に追加されていることが分かります。ここで必要な値を指定します。

        // You will set your application's clientId and redirect URI. 
        NSString * const kRedirectUri = @"ENTER_YOUR_REDIRECT_URI";
        NSString * const kClientId    = @"ENTER_YOUR_CLIENT_ID";
        NSString * const kAuthority   = @"https://login.microsoftonline.com/common";
        NSString * const kResourceId  = @"https://graph.microsoft.com";
    
    > メモ: CLIENT_ID と REDIRECT_URI の値がない場合は、[ネイティブ クライアント アプリケーションを Azure に追加](https://msdn.microsoft.com/ja-jp/library/azure/dn132599.aspx#BKMK_Adding)し、CLIENT_ID と REDIRECT_URI を書き留めます。

5. サンプルを実行します。

サンプルについて詳しくは、「[iOS アプリで Microsoft Graph を呼び出す](https://graph.microsoft.io/ja-jp/docs/platform/ios)」をご覧ください。

## 質問とコメント

Office 365 iOS Microsoft Graph Connect プロジェクトに関するフィードバックをお寄せください。質問や提案につきましては、このリポジトリの「[問題](https://github.com/OfficeDev/O365-iOS-Microsoft-Graph-Connect/issues)」セクションで送信できます。

Office 365 開発全般の質問につきましては、「[スタック オーバーフロー](http://stackoverflow.com/questions/tagged/Office365+API)」に投稿してください。質問やコメントには、必ず [Office365] と [MicrosoftGraph] のタグを付けてください。

## 投稿
プル要求を送信する前に、[投稿者のライセンス契約](https://cla.microsoft.com/)に署名する必要があります。投稿者のライセンス契約 (CLA) を完了するには、ドキュメントへのリンクを含む電子メールを受信した際に、フォームから要求を送信し、CLA に電子的に署名する必要があります。


## その他の技術情報

* [Office デベロッパー センター](http://dev.office.com/)
* [Microsoft Graph の概要ページ](https://graph.microsoft.io)
* [CocoaPods を使う](https://guides.cocoapods.org/using/using-cocoapods.html)

## 著作権
Copyright (c) 2015 Microsoft.All rights reserved.
