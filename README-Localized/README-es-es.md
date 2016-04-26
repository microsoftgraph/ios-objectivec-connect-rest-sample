# Ejemplo Connect de Office 365 para iOS con Microsoft Graph

Conectarse a Office 365 es el primer paso que debe realizar cada aplicación iOS para empezar a trabajar con los datos y servicios de Office 365. Este ejemplo muestra cómo conectar y cómo llamar después a una API a través de Microsoft Graph (anteriormente denominada API unificada de Office 365).

> Nota: Consulte [Introducción a las API de Office 365](http://dev.office.com/getting-started/office365apis?platform=option-ios#setup), que simplifica el registro para que este ejemplo se ejecute más rápidamente.
 
## Requisitos previos
* [Xcode](https://developer.apple.com/xcode/downloads/) de Apple
* Instalación de [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html) como administrador de dependencias.
* Una cuenta de Office 365. Puede registrarse en [una suscripción a Office 365 Developer](https://portal.office.com/Signup/Signup.aspx?OfferId=6881A1CB-F4EB-4db3-9F18-388898DAF510&DL=DEVELOPERPACK&ali=1#0), que incluye los recursos que necesita para comenzar a crear aplicaciones de Office 365.

    > Nota: Si ya dispone de una suscripción, el vínculo anterior le dirige a una página con el mensaje *No se puede agregar a su cuenta actual*. En ese caso, use una cuenta de su suscripción actual a Office 365.
* Un inquilino de Microsoft Azure para registrar la aplicación. Azure Active Directory (AD) proporciona servicios de identidad que las aplicaciones usan para autenticación y autorización. Puede adquirir una suscripción de prueba aquí: [Microsoft Azure](https://account.windowsazure.com/SignUp).

     > Importante: También necesitará asegurarse de que su suscripción a Azure esté enlazada a su inquilino de Office 365. Para ello, consulte la publicación del blog del equipo de Active Directory, [Crear y administrar varios directorios de Windows Azure Active Directory](http://blogs.technet.com/b/ad/archive/2013/11/08/creating-and-managing-multiple-windows-azure-active-directories.aspx). La sección **Agregar un nuevo directorio** le explicará cómo hacerlo. Para obtener más información, también puede consultar [Configurar el entorno de desarrollo de Office 365](https://msdn.microsoft.com/office/office365/howto/setup-development-environment#bk_CreateAzureSubscription) y la sección **Asociar su cuenta de Office 365 con Azure AD para crear y administrar aplicaciones**.
      
* Los valores de identificador de cliente y URI de redireccionamiento de una aplicación registrada en Azure. A esta aplicación de ejemplo se le debe conceder el permiso **Enviar correo como usuario** para **Microsoft Graph**. Para crear el registro, consulte **Registrar la aplicación nativa con el Portal de administración de Azure** en [Registrar manualmente la aplicación con Azure AD para que pueda acceder a las API de Office 365](https://msdn.microsoft.com/en-us/office/office365/howto/add-common-consent-manually) y [conceder permisos adecuados](https://github.com/OfficeDev/O365-iOS-Microsoft-Graph-Connect/wiki/Grant-permissions-to-the-Connect-application-in-Azure) en la wiki de ejemplo para aplicarle los permisos adecuados.


       
## Ejecutar este ejemplo en Xcode

1. Clone este repositorio.
2. Use CocoaPods para importar la dependencia iOS de la biblioteca de autenticación de Active Directory (ADAL):
        
	     pod 'ADALiOS', '= 1.2.4'

 Esta aplicación de ejemplo ya contiene un podfile que recibirá los componentes ADAL (pods) en el proyecto. Simplemente vaya al proyecto desde **Terminal** y ejecute:
        
        pod install
        
   Para obtener más información, consulte **Usar CocoaPods** en [Recursos adicionales](#AdditionalResources)
  
3. Abra **O365-iOS-Microsoft-Graph-Connect.xcworkspace**.
4. Abra **ConnectViewController.m**. Verá que los valores **ClientID** y **RedirectUri** pueden agregarse en la parte superior del archivo. Proporcione los valores necesarios aquí:

        // You will set your application's clientId and redirect URI. 
        NSString * const kRedirectUri = @"ENTER_YOUR_REDIRECT_URI";
        NSString * const kClientId    = @"ENTER_YOUR_CLIENT_ID";
        NSString * const kAuthority   = @"https://login.microsoftonline.com/common";
        NSString * const kResourceId  = @"https://graph.microsoft.com";
    
    > Nota: Si no dispone de los valores CLIENT_ID y REDIRECT_URI, [agregue una aplicación de cliente nativa en Azure](https://msdn.microsoft.com/es-es/library/azure/dn132599.aspx#BKMK_Adding) y anote los valores CLIENT_ID y REDIRECT_URI.

5. Ejecute el ejemplo.

Para obtener más información acerca del ejemplo, consulte [Llamar a Microsoft Graph en una aplicación iOS](https://graph.microsoft.io/es-es/docs/platform/ios).

## Preguntas y comentarios

Nos encantaría recibir sus comentarios sobre el proyecto Connect de Office 365 para iOS con Microsoft Graph. Puede enviarnos sus preguntas y sugerencias a través de la sección [Problemas](https://github.com/OfficeDev/O365-iOS-Microsoft-Graph-Connect/issues) de este repositorio.

Las preguntas generales sobre desarrollo en Office 365 deben publicarse en [Stack Overflow](http://stackoverflow.com/questions/tagged/Office365+API). Asegúrese de que sus preguntas o comentarios se etiquetan con [Office365] y [MicrosoftGraph].

## Colaboradores
Deberá firmar un [Contrato de licencia de colaborador](https://cla.microsoft.com/) antes de enviar la solicitud de incorporación de cambios. Para completar el Contrato de licencia de colaborador (CLA), deberá enviar una solicitud mediante el formulario y, a continuación, firmar electrónicamente el CLA cuando reciba el correo electrónico que contiene el vínculo al documento.


## Recursos adicionales

* [Centro para desarrolladores de Office](http://dev.office.com/)
* [Página de información general de Microsoft Graph](https://graph.microsoft.io)
* [Usar CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

## Copyright
Copyright (c) 2015 Microsoft. Todos los derechos reservados.
