/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See full license at the bottom of this file.
 */

#import <MSAL/MSAL.h>
#import "AuthenticationManager.h"

@interface AuthenticationManager()

@property (nonatomic) NSString *accessToken;
@property (nonatomic) MSALPublicClientApplication *msalClient;
@property (nonatomic) MSALAccount *account;

@end

@implementation AuthenticationManager

- (instancetype)initWithAuthority:(MSALAuthority *)authority
                         clientId:(NSString *)clientId
                            error:(NSError **)error
{
    self = [super init];
    if (self) {
        MSALPublicClientApplicationConfig *config = [[MSALPublicClientApplicationConfig alloc] initWithClientId:clientId];
        config.authority = authority;
        
        NSError *localError;
        _msalClient = [[MSALPublicClientApplication alloc] initWithConfiguration:config error:&localError];
        
        if (localError) {
            if (error) *error = localError;
            return nil;
        }
    }
    
    return self;
}

- (void)acquireAuthTokenWithScopes:(NSArray<NSString *> *)scopes
                        completion:(void(^)(BOOL success, NSError *error))completion
{
    assert(completion);
    
    MSALCompletionBlock completionBlock;
    __block __weak MSALCompletionBlock weakCompletionBlock;
    weakCompletionBlock = completionBlock = ^(MSALResult *result, NSError *error)
    {
        if (!error) {
            self.accessToken = result.accessToken;
            self.account = result.account;
            completion(YES, nil);
            
            return;
        }
        
        if ([error.domain isEqualToString:MSALErrorDomain]) {
            switch (error.code) {
                case MSALErrorInteractionRequired:
                {
                    // Interactive auth will be required
                    __auto_type interactiveParameters = [[MSALInteractiveTokenParameters alloc] initWithScopes:scopes];
                    [self.msalClient acquireTokenWithParameters:interactiveParameters
                                                completionBlock:weakCompletionBlock];
                    
                    return;
                }
                    
                case MSALErrorServerDeclinedScopes:
                {
                    NSArray *declinedScopes = error.userInfo[MSALDeclinedScopesKey];
                    NSLog(@"The following scopes were declined: %@", declinedScopes);
                    
                    NSArray *grantedScopes = error.userInfo[MSALGrantedScopesKey];
                    NSLog(@"Trying to acquire a token with granted scopes: %@", grantedScopes);
                    
                    NSError *localError;
                    NSArray<MSALAccount *> *accounts = [self.msalClient allAccounts:&localError];
                    
                    if (localError) {
                        completion(NO, localError);
                        return;
                    }
                    
                    __auto_type silentParameters = [[MSALSilentTokenParameters alloc] initWithScopes:grantedScopes account:accounts.firstObject];
                    [self.msalClient acquireTokenSilentWithParameters:silentParameters
                                                      completionBlock:weakCompletionBlock];
                    return;
                }
                    
                case MSALErrorInternal:
                {
                    // Log the error, then inspect the MSALInternalErrorCodeKey
                    // in the userInfo dictionary.
                    // More detailed information about the specific error
                    // under MSALInternalErrorCodeKey can be found in MSALInternalError enum.
                    NSLog(@"Failed with internal MSAL error %@", error);
                    
                    break;
                }
                    
                default:
                    NSLog(@"Failed with unknown MSAL error %@", error);
                    break;
            }
        }
        
        completion(NO, error);
    };
    
    
    NSError *localError;
    NSArray<MSALAccount *> *accounts = [self.msalClient allAccounts:&localError];
    
    if (localError) {
        completion(NO, localError);
        return;
    }
    
    if (accounts.count > 0) {
        __auto_type silentParameters = [[MSALSilentTokenParameters alloc] initWithScopes:scopes account:accounts.firstObject];
        [self.msalClient acquireTokenSilentWithParameters:silentParameters completionBlock:completionBlock];
    } else {
        __auto_type interactiveParameters = [[MSALInteractiveTokenParameters alloc] initWithScopes:scopes];
        [self.msalClient acquireTokenWithParameters:interactiveParameters completionBlock:completionBlock];
    }
}

- (void)clearCredentials
{
    NSError *error;
    [self.msalClient removeAccount:self.account error:&error];
    
    if (error) NSLog(@"Error: %@", error);
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
