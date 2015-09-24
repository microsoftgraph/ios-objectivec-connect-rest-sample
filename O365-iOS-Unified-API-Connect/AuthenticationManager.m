/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See full license at the bottom of this file.
 */

#import "AuthenticationManager.h"
#import <ADAuthenticationContext.h>

@interface AuthenticationManager()

@property (nonatomic, strong) NSString *authority;
@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *redirectUri;
@property (nonatomic, strong) NSString *resourceID;

@property (nonatomic, strong) ADAuthenticationContext *context;

@end

@implementation AuthenticationManager

#pragma mark - singleton
+ (AuthenticationManager *)sharedInstance
{
    static AuthenticationManager *sharedInstance;
    static dispatch_once_t onceToken;
    
    // Initialize the AuthenticationManager only once.
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AuthenticationManager alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - init
- (void)initWithAuthority:(NSString*)authority
                 clientId:(NSString*)clientId
              redirectURI:(NSString*)redirectURI
               resourceID:(NSString*)resourceID
               completion:(void (^)(ADAuthenticationError *error))completion
{
    ADAuthenticationError *error;
    _context = [ADAuthenticationContext authenticationContextWithAuthority:authority error:&error];
    
    if(error){
        // Log error
        completion(error);
    }
    else{
        self.clientID = clientId;
        self.redirectUri = redirectURI;
        self.authority = authority;
        self.resourceID = resourceID;
        
        completion(nil);
    }
}

#pragma mark - acquire token
- (void)acquireAuthTokenCompletion:(void (^)(ADAuthenticationError *error))completion {
    [self acquireAuthTokenWithResource:self.resourceID
                              clientID:self.clientID
                           redirectURI: [NSURL URLWithString:self.redirectUri]
                            completion:^(ADAuthenticationError *error) {
                                completion(error);}];
}

- (void)acquireAuthTokenWithResource:(NSString *)resourceID
                            clientID:(NSString*)clientID
                         redirectURI:(NSURL*)redirectURI
                          completion:(void (^)(ADAuthenticationError *error))completion {
    
    NSLog(@"acquireAuthTokenWithResource");
    [self.context acquireTokenWithResource:resourceID
                                  clientId:clientID
                               redirectUri:redirectURI
                           completionBlock:^(ADAuthenticationResult *result) {
                               NSLog(@"Completion");
                               
                               if (result.status !=AD_SUCCEEDED){
                                   NSLog(@"error");
                                   completion(result.error);
                               }
                               
                               else{
                                   NSLog(@"complete!");
                                   self.accessToken = result.accessToken;
                                   self.userID = result.tokenCacheStoreItem.userInformation.userId;
                                   completion(nil);
                               }
                           }];
}

#pragma mark - clear credentials
 //Clears the ADAL token cache and the cookie cache.
- (void)clearCredentials {

    // Remove all the cookies from this application's sandbox. The authorization code is stored in the
    // cookies and ADAL will try to get to access tokens based on auth code in the cookie.
    NSHTTPCookieStorage *cookieStore = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in cookieStore.cookies) {
        [cookieStore deleteCookie:cookie];
    }
    
    [self.context.tokenCacheStore removeAllWithError:nil];
}

@end

// *********************************************************
//
// O365-iOS-Unified-API-Connect, https://github.com/OfficeDev/O365-iOS-Unified-API-Connect
//
// Copyright (c) Microsoft Corporation
// All rights reserved.
//
// MIT License:
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// *********************************************************
