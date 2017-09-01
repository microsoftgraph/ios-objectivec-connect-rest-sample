# Office 365 Connect Sample for iOS Using Microsoft Graph

Connecting to Office 365 is the first step every iOS app must take to start working with Office 365 services and data. This sample shows how to connect and then call one API through Microsoft Graph (previously called Office 365 unified API).

 
## Prerequisites
* [Xcode](https://developer.apple.com/xcode/downloads/) from Apple
* An Office 365 account. You can sign up for [an Office 365 Developer subscription](https://aka.ms/devprogramsignup) that includes the resources that you need to start building Office 365 apps.

     > Note: If you already have a subscription, the previous link sends you to a page with the message *Sorry, you can’t add that to your current account*. In that case, use an account from your current Office 365 subscription.
* A Microsoft Azure tenant to register your application. Azure Active Directory (AD) provides identity services that applications use for authentication and authorization. A trial subscription can be acquired here: [Microsoft Azure](https://account.windowsazure.com/SignUp).

     > Important: You will also need to ensure your Azure subscription is bound to your Office 365 tenant. To do this, see the Active Directory team's blog post, [Creating and Managing Multiple Windows Azure Active Directories](http://blogs.technet.com/b/ad/archive/2013/11/08/creating-and-managing-multiple-windows-azure-active-directories.aspx). The section **Adding a new directory** will explain how to do this. You can also see [Set up your Office 365 development environment](https://msdn.microsoft.com/office/office365/howto/setup-development-environment#bk_CreateAzureSubscription) and the section **Associate your Office 365 account with Azure AD to create and manage apps** for more information.
      
* A client id (application id) and redirect uri values of an application registered in Azure. This sample application must be granted the **Send mail as user** permission for **Microsoft Graph**. To create the registration, see [Grant permissions to the Connect application in Azure](https://github.com/microsoftgraph/ios-objectivec-connect-rest-sample/wiki/Grant-permissions-to-the-Connect-application-in-Azure).


       
## Running this sample in Xcode

1. Clone this repository
2. Use [Carthage](https://github.com/Carthage/Carthage) to import the Microsoft Authenticaion Library (MSAL) iOS dependency. Download the latest version of Carthage [here](https://github.com/Carthage/Carthage/releases). 
3. Open **O365-iOS-Microsoft-Graph-Connect.xcworkspace**
4. Open **info.plist**. You'll see that the **ClientID** (application id you received from the registration process in the prerequisites section) goes here.
  ```xml
    <key>CFBundleURLTypes</key>
      <array>
          <dict>
              <key>CFBundleTypeRole</key>
              <string>Editor</string>
              <key>CFBundleURLName</key>
              <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
              <key>CFBundleURLSchemes</key>
              <array>
                  <string>msal[ENTER_YOUR_CLIENT_ID]</string>
                  <string>auth</string>
              </array>
          </dict>
      </array>

  ```

    
## Build the MSAL framework

The preview version of MSAL is distributed as source code using Carthage. To build the source code, do these steps:

1. Open the Bash terminal and go to the app root folder.
2. Create a **cartfile**: Copy `echo "github \"AzureAD/microsoft-authentication-library-for-objc\" \"master\"" > Cartfile`  into the terminal and run the command.
3. Build the MSAL library: Copy `carthage update` into the terminal and run the command.        

5. Run the sample.

To learn more about the sample, see [Call Microsoft Graph in an iOS App](https://graph.microsoft.io/en-us/docs/platform/ios).

## Questions and comments

We'd love to get your feedback about the Office 365 iOS Microsoft Graph Connect project. You can send your questions and suggestions to us in the [Issues](https://github.com/OfficeDev/O365-iOS-Microsoft-Graph-Connect/issues) section of this repository.

Questions about Office 365 development in general should be posted to [Stack Overflow](http://stackoverflow.com/questions/tagged/Office365+API). Make sure that your questions or comments are tagged with [Office365] and [MicrosoftGraph].

## Contributing
You will need to sign a [Contributor License Agreement](https://cla.microsoft.com/) before submitting your pull request. To complete the Contributor License Agreement (CLA), you will need to submit a request via the form and then electronically sign the CLA when you receive the email containing the link to the document. 

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Additional resources

* [Office Dev Center](http://dev.office.com/)
* [Microsoft Graph overview page](https://graph.microsoft.io)
* [Using CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

## Copyright
Copyright (c) 2017 Microsoft. All rights reserved.
