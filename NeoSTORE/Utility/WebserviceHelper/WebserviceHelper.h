//
//  WebserviceHelper.h
//  NeoSTORE
//
//  Created by webwerks on 7/29/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Base_URL @"http://staging.php-dev.in:8844/trainingapp/api/"

typedef void (^Completion_Block)(id response, NSString *error);

@interface WebserviceHelper : NSObject
{
    NSURLSession *session;
    NSMutableString *parameterString;
    NSURL *serverUrl;
    NSMutableURLRequest *request;
    NSURLSessionDataTask *sessionDataTask;
    NSData *postData;
    NSString *postLength;
    NSURLSessionDataTask *dataTask;
}

//Get Methods

-(void)GetWebserviceWithParameterAndAccessToken:(NSDictionary *)parameters withHud:(BOOL)isHud User:(NSString *)endUser Screen:(NSString *)screen AcessToken:(NSString*)acessToken completionBlock:(Completion_Block)block;

//post Method

-(void)PostWebserviceWithParameterAndAccessToken:(NSDictionary *)parameters withHud:(BOOL)isHud User:(NSString *)endUser Screen:(NSString *)screen AcessToken:(NSString*)acessToken completionBlock:(Completion_Block)block;

+ (WebserviceHelper *)sharedInstance;

@end
