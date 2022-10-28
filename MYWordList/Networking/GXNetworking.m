//
//  GXNetworking.m
//  BJNewsUtils
//
//  Created by wolffy on 2020/12/25.
//  Copyright © 2020 光线传媒. All rights reserved.
//

#import "GXNetworking.h"

static GXNetworking * gx_net_manager = nil;

#define GX_TIME_OUT 15.0

@interface GXNetworking ()

@property (nonatomic,strong) NSMutableArray * taskArray;

@end

@implementation GXNetworking

+ (GXNetworking *)defaultManager{
    if(gx_net_manager == nil){
        gx_net_manager = [[GXNetworking alloc]init];
    }
    return gx_net_manager;
}

#pragma mark -
#pragma mark - 基础 GET POST PUT DELETE

- (NSMutableArray *)taskArray{
    if(_taskArray == nil){
        _taskArray = [[NSMutableArray alloc]init];
    }
    return _taskArray;
}

- (void)removeDataTask:(GXSessionRequest *)request{
    if(request == nil){
        return;
    }
    @try {
        if([self.taskArray containsObject:request]){
            [self.taskArray removeObject:request];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma mark - GET

/**
 发起GET请求
 
 @param host 主机url
 @param headers 请求头
 @param finished 成功回调
 @param failed 失败回调
 */
+ (GXSessionRequest *)GETWithHost:(NSString *)host headers:(NSDictionary *)headers finished:(void (^)(NSURLResponse * response,NSData * responseData))finished failed:(void (^) (NSURLResponse * response,NSData * responseData))failed{
    GXSessionRequest * request = [[GXNetworking defaultManager] GETWithHost:host headers:headers timeoutInterval:GX_TIME_OUT finished:finished failed:failed];
    return request;
}

+ (GXSessionRequest *)GETWithHost:(NSString *)host query:(NSDictionary *)query headers:(NSDictionary *)headers finished:(void (^)(NSURLResponse * response,NSData * responseData))finished failed:(void (^) (NSURLResponse * response,NSData * responseData))failed{
    host = [GXNetworkingTools getUrlWithHost:host queryParameters:query];
    GXSessionRequest * request = [GXNetworking GETWithHost:host headers:headers finished:finished failed:failed];
    return request;
}

- (GXSessionRequest *)GETWithHost:(NSString *)host headers:(NSDictionary *)headers timeoutInterval:(float)time finished:(void (^)(NSURLResponse * response,NSData * responseData))finished failed:(void (^) (NSURLResponse * response,NSData * responseData))failed{
    GXSessionRequest * request = [[GXSessionRequest alloc]init];
    [self.taskArray addObject:request];
    __weak typeof(self) weak_self = self;
    [request GETWithHost:host headers:headers timeoutInterval:time finished:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData) {
        [weak_self removeDataTask:request];
        if(finished){
            finished(response,responseData);
        }
    } failed:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData) {
        [weak_self removeDataTask:request];
        if(failed){
            failed(response,responseData);
        }
    }];;
    return request;
}

#pragma mark - POST
/**
 发起POST请求

 @param host 主机url
 @param headers 请求头
 @param parameters 请求体
 @param finished 成功回调
 @param failed 失败回调
 */
+ (GXSessionRequest *)POSTWithHost:(NSString *)host headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters finished:(void (^)(NSURLResponse * response,NSData * responseData))finished failed:(void (^) (NSURLResponse * response,NSData * responseData))failed{
    GXSessionRequest * request = [[GXNetworking defaultManager] POSTWithHost:host headers:headers parameters:parameters timeoutInterval:GX_TIME_OUT finished:finished failed:failed];
    return request;
}

- (GXSessionRequest *)POSTWithHost:(NSString *)host headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters timeoutInterval:(float)time finished:(void (^)(NSURLResponse * response,NSData * responseData))finished failed:(void (^) (NSURLResponse * response,NSData * responseData))failed{
    GXSessionRequest * request = [[GXSessionRequest alloc]init];
       __weak typeof(self) weak_self = self;
    [request POSTWithHost:host headers:headers parameters:parameters timeoutInterval:time finished:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData) {
           [weak_self removeDataTask:request];
           if(finished){
               finished(response,responseData);
           }
       } failed:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData) {
           [weak_self removeDataTask:request];
           if(failed){
               failed(response,responseData);
           }
       }];
       return request;
}

#pragma mark - PUT
/**
 发起PUT请求
 
 @param host 主机url
 @param headers 请求头
 @param parameters 请求体
 @param finished 成功回调
 @param failed 失败回调
 */
+ (GXSessionRequest *)PUTWithHost:(NSString *)host headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters finished:(void (^)(NSURLResponse * response,NSData * responseData))finished failed:(void (^) (NSURLResponse * response,NSData * responseData))failed{
    GXSessionRequest * request = [[GXNetworking defaultManager] PUTWithHost:host headers:headers parameters:parameters timeoutInterval:GX_TIME_OUT finished:finished failed:failed];
    return request;
}

- (GXSessionRequest *)PUTWithHost:(NSString *)host headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters timeoutInterval:(float)time finished:(void (^)(NSURLResponse * response,NSData * responseData))finished failed:(void (^) (NSURLResponse * response,NSData * responseData))failed{
    GXSessionRequest * request = [[GXSessionRequest alloc]init];
    __weak typeof(self) weak_self = self;
    [request PUTWithHost:host headers:headers parameters:parameters timeoutInterval:time finished:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData) {
        [weak_self removeDataTask:request];
        if(finished){
            finished(response,responseData);
        }
    } failed:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData) {
        [weak_self removeDataTask:request];
        if(failed){
            failed(response,responseData);
        }
    }];
    return request;
}


#pragma mark - DELETE
/**
 发起DELETE请求
 
 @param host 主机url
 @param headers 请求头
 @param finished 成功回调
 @param failed 失败回调
 */
+ (GXSessionRequest *)DELETEWithHost:(NSString *)host headers:(NSDictionary *)headers finished:(void (^)(NSURLResponse * response,NSData * responseData))finished failed:(void (^) (NSURLResponse * response,NSData * responseData))failed{
    GXSessionRequest * request = [[GXNetworking defaultManager] DELETEWithHost:host headers:headers timeoutInterval:GX_TIME_OUT finished:finished failed:failed];
    return request;
}

- (GXSessionRequest *)DELETEWithHost:(NSString *)host headers:(NSDictionary *)headers timeoutInterval:(float)time finished:(void (^)(NSURLResponse * response,NSData * responseData))finished failed:(void (^) (NSURLResponse * response,NSData * responseData))failed{
    GXSessionRequest * request = [[GXSessionRequest alloc]init];
    __weak typeof(self) weak_self = self;
    [request DELETEWithHost:host headers:headers timeoutInterval:time finished:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData) {
        [weak_self removeDataTask:request];
        if(finished){
            finished(response,responseData);
        }
    } failed:^(NSURLResponse * _Nonnull response, NSData * _Nonnull responseData) {
        [weak_self removeDataTask:request];
        if(failed){
            failed(response,responseData);
        }
    }];
    return request;
}

@end
