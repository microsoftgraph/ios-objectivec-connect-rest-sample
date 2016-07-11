# Пример приложения iOS, подключающегося к Office 365 и использующего Microsoft Graph

Подключение к Office 365 — это первый шаг, который должно выполнить каждое приложение iOS, чтобы начать работу со службами и данными Office 365. В этом примере показано, как подключить, а затем вызвать один API с помощью Microsoft Graph (прежнее название — единый API Office 365).

> Примечание. Перейдите на страницу [Начало работы с API Office 365](http://dev.office.com/getting-started/office365apis?platform=option-ios#setup) для упрощенной регистрации, чтобы ускорить запуск этого примера.
 
## Предварительные требования
* [Xcode](https://developer.apple.com/xcode/downloads/) от Apple.
* Установка [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) в качестве диспетчера зависимостей.
* Учетная запись Office 365. Вы можете [подписаться на план Office 365 для разработчиков](https://profile.microsoft.com/RegSysProfileCenter/wizardnp.aspx?wizid=14b845d0-938c-45af-b061-f798fbb4d170), включающий ресурсы, которые необходимы для создания приложений Office 365.

    > Примечание. Если у вас уже есть подписка, при выборе приведенной выше ссылки откроется страница с сообщением *К сожалению, вы не можете добавить это к своей учетной записи*. В этом случае используйте учетную запись, сопоставленную с текущей подпиской на Office 365.
* Клиент Microsoft Azure для регистрации приложения. В Azure Active Directory (AD) доступны службы идентификации, которые приложения используют для проверки подлинности и авторизации. Здесь можно получить пробную подписку: [Microsoft Azure](https://account.windowsazure.com/SignUp).

     > Внимание! Убедитесь, что ваша подписка на Azure привязана к клиенту Office 365. Для этого просмотрите запись в блоге команды Active Directory, посвященную [созданию нескольких каталогов Microsoft Azure AD и управлению ими](http://blogs.technet.com/b/ad/archive/2013/11/08/creating-and-managing-multiple-windows-azure-active-directories.aspx). Инструкции приведены в разделе о **добавлении нового каталога**. Дополнительные сведения см. в статье [Как настроить среду разработки для Office 365](https://msdn.microsoft.com/office/office365/howto/setup-development-environment#bk_CreateAzureSubscription) и, в частности, в разделе **Связывание Azure AD и учетной записи Office 365 для создания приложений и управления ими**.
      
* Универсальный код ресурса (URI) для перенаправления и идентификатор клиента, указанные при регистрации приложения в Azure. Этому приложению необходимо предоставить разрешение **Отправка почты от имени пользователя** для **Microsoft Graph**. Указания по регистрации см. в разделе **Регистрация основного приложения на портале управления Azure** статьи [Регистрация приложения в Azure AD вручную, чтобы оно могло получить доступ к API Office 365](https://msdn.microsoft.com/en-us/office/office365/howto/add-common-consent-manually). Кроме того, см. инструкции по [предоставлению необходимых разрешений](https://github.com/OfficeDev/O365-iOS-Microsoft-Graph-Connect/wiki/Grant-permissions-to-the-Connect-application-in-Azure) на соответствующей вкладке вики-статьи.


       
## Запуск этого примера в Xcode

1. Клонируйте этот репозиторий.
2. С помощью CocoaPods импортируйте зависимость iOS из библиотеки ADAL:
        
	     pod 'ADALiOS', '= 1.2.4'

 Этот пример приложения уже содержит компонент podfile, который добавит компоненты ADAL (pod) в проект. Просто перейдите к проекту из раздела **Терминал** и выполните следующую команду:
        
        pod install
        
   Для получения дополнительных сведений выберите ссылку **Использование CocoaPods** в разделе [Дополнительные ресурсы](#AdditionalResources).
  
3. Откройте **O365-iOS-Microsoft-Graph-Connect.xcworkspace**.
4. Откройте файл **ConnectViewController.m**. Вы увидите, что значения **ClientID** и **RedirectUri** можно добавить в верхнюю часть файла. Введите здесь все необходимые значения:

        // You will set your application's clientId and redirect URI. 
        NSString * const kRedirectUri = @"ENTER_YOUR_REDIRECT_URI";
        NSString * const kClientId    = @"ENTER_YOUR_CLIENT_ID";
        NSString * const kAuthority   = @"https://login.microsoftonline.com/common";
        NSString * const kResourceId  = @"https://graph.microsoft.com";
    
    > Примечание. Если у вас нет значений CLIENT_ID и REDIRECT_URI, [добавьте основное клиентское приложение в Azure](https://msdn.microsoft.com/ru-ru/library/azure/dn132599.aspx#BKMK_Adding) и запишите CLIENT_ID и REDIRECT_URI.

5. Запустите приложение.

Дополнительные сведения о приложении см. в статье [Вызов Microsoft Graph в приложении для iOS](https://graph.microsoft.io/ru-ru/docs/platform/ios).

## Вопросы и комментарии

Мы будем рады получить от вас отзывы о проекте приложения iOS, подключающегося к Office 365 и использующего Microsoft Graph. Отправляйте нам свои вопросы и предложения в раздел этого репозитория, посвященный [проблемам](https://github.com/OfficeDev/O365-iOS-Microsoft-Graph-Connect/issues).

Общие вопросы о разработке решений для Office 365 следует публиковать на сайте [Stack Overflow](http://stackoverflow.com/questions/tagged/Office365+API). Обязательно помечайте свои вопросы и комментарии тегами [Office365] и [MicrosoftGraph].

## Участие
Прежде чем отправить запрос на включение внесенных изменений, необходимо подписать [лицензионное соглашение с участником](https://cla.microsoft.com/). Чтобы заполнить лицензионное соглашение с участником (CLA), вам потребуется отправить запрос с помощью формы, а затем после получения электронного сообщения со ссылкой на этот документ подписать CLA с помощью электронной подписи.


## Дополнительные ресурсы

* [Центр разработки для Office](http://dev.office.com/)
* [Страница с общими сведениями о Microsoft Graph](https://graph.microsoft.io)
*[Использование CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

## Авторские права
(c) Корпорация Майкрософт (Microsoft Corporation), 2015. Все права защищены.
