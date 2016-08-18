//
//  WebserviceHelper.m
//  NeoSTORE
//
//  Created by webwerks on 7/29/16.
//  Copyright © 2016 RanjitChougale_NeoSoft. All rights reserved.
//

#import "WebserviceHelper.h"
#import "Reachability.h"
#import "SVProgressHUD.h"

@implementation WebserviceHelper

#pragma get methods implementation
-(void)GetWebserviceWithParameterAndAccessToken:(NSDictionary *)parameters withHud:(BOOL)isHud User:(NSString *)endUser Screen:(NSString *)screen AcessToken:(NSString*)acessToken completionBlock:(Completion_Block)block
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (isHud){
            [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
            [SVProgressHUD setForegroundColor:[UIColor redColor]];
            [SVProgressHUD showWithStatus:@"Loading..."];
        }
    });
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    parameterString = [[NSMutableString alloc]init];
    
    if (parameters == NULL)
    {
        if (parameters)
        {
            [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
             {
                 [parameterString appendFormat:@"%@=%@", key, obj];
             }];
            serverUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@?%@",Base_URL, endUser, screen,parameterString]];
        }
        else
        {
            if (endUser == NULL)
                serverUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_URL, screen]];
            else
                serverUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@",Base_URL, endUser, screen]];
        }
        
        request = [NSMutableURLRequest requestWithURL:serverUrl];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:acessToken forHTTPHeaderField:@"access_token"];
    }
    
    else if (acessToken == NULL)
    {
        if (parameters)
        {
            [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
             {
                 [parameterString appendFormat:@"%@=%@", key, obj];
             }];
            
            serverUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@?%@",Base_URL,endUser,screen,parameterString]];
        }
        else
            serverUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@",Base_URL,endUser,screen]];
        
        request = [NSMutableURLRequest requestWithURL:serverUrl];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    
    else
    {
        if(parameters)
        {
            [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
             {
                 [parameterString appendFormat:@"%@=%@", key, obj];
             }];
            
            serverUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@",Base_URL,screen,parameterString]];
            
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        }
        else
        {
            serverUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_URL,screen]];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        }
        request = [NSMutableURLRequest requestWithURL:serverUrl];
        [request setValue:acessToken forHTTPHeaderField:@"access_token"];
    }
    
    request.HTTPMethod = @"GET";
    
    sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                       {
                           dispatch_async(dispatch_get_main_queue(), ^{
                               if (isHud)
                               {
                                   [SVProgressHUD dismiss];
                               }
                           });
                           
                           if([data isKindOfClass:[NSData class]])
                           {
                               id responseData=[self parseJsondata:data];
                               if (responseData)
                               {
                                   if([responseData isKindOfClass:[NSDictionary class]])
                                   {
                                   }
                                   else if([responseData isKindOfClass:[NSArray class]])
                                   {
                                   }
                                   block(responseData,screen);
                                   return ;
                               }
                           }
                           block(nil,[error description]);
                       }];
    
    [sessionDataTask resume];
}

#pragma  post method implementation
-(void)PostWebserviceWithParameterAndAccessToken:(NSDictionary *)parameters withHud:(BOOL)isHud User:(NSString *)endUser Screen:(NSString *)screen AcessToken:(NSString*)acessToken completionBlock:(Completion_Block)block
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (isHud){
            [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
            [SVProgressHUD setForegroundColor:[UIColor redColor]];
            [SVProgressHUD showWithStatus:@"Loading..."];
        }
    });
    
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    parameterString = [[NSMutableString alloc]init];
    
    if (acessToken==NULL)
    {
        serverUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@",Base_URL,endUser,screen]];
        request = [NSMutableURLRequest requestWithURL:serverUrl];
        
        [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
         {
             [parameterString appendFormat:@"&%@=%@", key, obj];
         }];
    }
    else
    {
        if(endUser && screen)
        {
            serverUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@",Base_URL,endUser,screen]];
            request = [NSMutableURLRequest requestWithURL:serverUrl];
        }
        else if(endUser || screen)
        {
            if (endUser==NULL)
            {
                serverUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_URL,screen]];
                request = [NSMutableURLRequest requestWithURL:serverUrl];
            }
            else
            {
                serverUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_URL,endUser]];
                request = [NSMutableURLRequest requestWithURL:serverUrl];
            }
        }
        [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
         {
             [parameterString appendFormat:@"&%@=%@", key, obj];
         }];
        
        [request setValue:acessToken forHTTPHeaderField:@"access_token"];
        
    }
    
    postData = [parameterString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: postData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                       {
                           dispatch_async(dispatch_get_main_queue(), ^{
                               if (isHud){
                                   [SVProgressHUD dismiss];
                               }
                           });
                           if([data isKindOfClass:[NSData class]])
                           {
                               id responseData=[self parseJsondata:data];
                               if (responseData)
                               {
                                   if([responseData isKindOfClass:[NSDictionary class]])
                                   {
                                   }
                                   else if([responseData isKindOfClass:[NSArray class]])
                                   {
                                   }
                                   block(responseData,screen);
                                   return ;
                               }
                           }
                           block(nil,[error description]);
                       }];
   
    
    [sessionDataTask resume];
}

-(id)parseJsondata:(id)data
{
    if([data isKindOfClass:[NSData class]])
    {
        NSError *parseJsonError;
        id serviceResponse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseJsonError];
        if(!parseJsonError)
            return serviceResponse;
        return parseJsonError;
    }
    return nil;
}

//webservice instance
+ (WebserviceHelper *)sharedInstance
{
    static dispatch_once_t pred;
    static WebserviceHelper *sharedWebService = nil;
    
    dispatch_once(&pred, ^{
        sharedWebService = [WebserviceHelper new];
    });
    return sharedWebService;
}


@end
