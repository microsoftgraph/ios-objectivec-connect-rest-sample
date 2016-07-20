# Exemplo de conexão com o Office 365 para iOS usando o Microsoft Graph

A primeira etapa para que os aplicativos iOS comecem a funcionar com dados e serviços do Office 365 é estabelecer uma conexão com essa plataforma. Este exemplo mostra como se conectar e chamar uma única API do Microsoft Graph (antiga API unificada do Office 365).

> Observação: experimente a página [Introdução às APIs do Office 365](http://dev.office.com/getting-started/office365apis?platform=option-ios#setup), que simplifica o registro para que você possa executar esse exemplo com mais rapidez.
 
## Pré-requisitos
* [Xcode](https://developer.apple.com/xcode/downloads/) da Apple
* A instalação de [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) como um gerenciador de dependências.
* Uma conta do Office 365. Inscreva-se para uma [Assinatura de Desenvolvedor do Office 365](https://aka.ms/devprogramsignup), que inclui os recursos necessários para começar a criação de aplicativos do Office 365.

    > Observação: caso já tenha uma assinatura, o link anterior direciona você para uma página com a mensagem *Não é possível adicioná-la à sua conta atual*. Nesse caso, use uma conta de sua assinatura atual do Office 365.
* Um locatário do Microsoft Azure para registrar o seu aplicativo. O Active Directory (AD) do Azure fornece serviços de identidade que os aplicativos usam para autenticação e autorização. Você pode adquirir uma assinatura de avaliação aqui: [Microsoft Azure](https://account.windowsazure.com/SignUp).

     > Importante: você também deve assegurar que a assinatura do Azure esteja vinculada ao locatário do Office 365. Para saber como fazer isso, confira a postagem de blog da equipe do Active Directory, [Criando e gerenciando vários Active Directories do Microsoft Azure](http://blogs.technet.com/b/ad/archive/2013/11/08/creating-and-managing-multiple-windows-azure-active-directories.aspx). A seção **Adicionando um novo diretório** explica como fazer isso. Para saber mais, confira o artigo [Configurar o ambiente de desenvolvimento do Office 365](https://msdn.microsoft.com/office/office365/howto/setup-development-environment#bk_CreateAzureSubscription) e a seção **Associar uma conta do Office 365 ao AD do Azure para criar e gerenciar aplicativos**.
      
* Valores de uma ID do cliente e de um URI de redirecionamento de um aplicativo registrado no Azure. Esse exemplo de aplicativo deve ter a permissão **Enviar email como usuário** concedida para o **Microsoft Graph**. Para criar o registro, confira o tópico **Registrar o aplicativo nativo com o Portal de Gerenciamento do Azure**, no artigo [Registrar o aplicativo manualmente com o AD do Azure para que ele possa acessar as APIs do Office 365](https://msdn.microsoft.com/en-us/office/office365/howto/add-common-consent-manually) e [conceda as permissões adequadas](https://github.com/OfficeDev/O365-iOS-Microsoft-Graph-Connect/wiki/Grant-permissions-to-the-Connect-application-in-Azure) no exemplo de wiki para aplicá-las no registro.


       
## Executando esse exemplo no Xcode

1. Clonar esse repositório
2. Use o CocoaPods para importar a dependência de iOS da ADAL (Biblioteca de Autenticação do Active Directory):
        
	     pod 'ADALiOS', '= 1.2.4'

 Este exemplo de aplicativo já contém um podfile que receberá os componentes ADAL (pods) no projeto. Basta navegar para o projeto a partir do **Terminal** e executar:
        
        pod install
        
   Para saber mais, confira o artigo **Usando o CocoaPods** em [Recursos adicionais](#AdditionalResources)
  
3. Abra **O365-iOS-Microsoft-Graph-Connect.xcworkspace**
4. Abra **ConnectViewController.m**. Observe que você pode adicionar os valores de **ClientID** e **RedirectUri** na parte superior do arquivo. Forneça os valores necessários aqui:

        // You will set your application's clientId and redirect URI. 
        NSString * const kRedirectUri = @"ENTER_YOUR_REDIRECT_URI";
        NSString * const kClientId    = @"ENTER_YOUR_CLIENT_ID";
        NSString * const kAuthority   = @"https://login.microsoftonline.com/common";
        NSString * const kResourceId  = @"https://graph.microsoft.com";
    
    > Observação: caso não tenha os valores CLIENT_ID e REDIRECT_URI, [adicione um aplicativo cliente nativo no Azure](https://msdn.microsoft.com/pt-br/library/azure/dn132599.aspx#BKMK_Adding) e anote os valores do CLIENT_ID e do REDIRECT_URI.

5. Execute o exemplo.

Para saber mais sobre o exemplo, confira o artigo [Chamar o Microsoft Graph em um aplicativo iOS](https://graph.microsoft.io/pt-br/docs/platform/ios).

## Perguntas e comentários

Gostaríamos de saber sua opinião sobre o projeto de conexão com o Office 365 para iOS usando o Microsoft Graph. Você pode enviar perguntas e sugestões na seção [Problemas](https://github.com/OfficeDev/O365-iOS-Microsoft-Graph-Connect/issues) deste repositório.

Faça a postagem de perguntas sobre desenvolvimento do Office 365 em geral na página do [Stack Overflow](http://stackoverflow.com/questions/tagged/Office365+API). Não deixe de marcar as perguntas ou comentários com [Office365] e [MicrosoftGraph].

## Colaboração
Assine o [Contributor License Agreement (Contrato de Licença de Colaborador)](https://cla.microsoft.com/) antes de enviar a solicitação pull. Para concluir o CLA (Contributor License Agreement), você deve enviar uma solicitação através do formulário e assinar eletronicamente o CLA quando receber o email com o link para o documento.


## Recursos adicionais

* [Centro de Desenvolvimento do Office](http://dev.office.com/)
* [Página de visão geral do Microsoft Graph](https://graph.microsoft.io)
* [Usando o CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

## Direitos autorais
Copyright © 2015 Microsoft. Todos os direitos reservados.
