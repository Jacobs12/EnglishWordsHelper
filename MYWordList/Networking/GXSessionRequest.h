//
//  GXSessionRequest.h
//  BJNewsUtils
//
//  Created by wolffy on 2020/12/25.
//  Copyright © 2020 北京光线传媒股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "GXNetworkingTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface GXSessionRequest : NSObject

typedef NS_ENUM(NSInteger,GXRequestMethod){
    GXRequestMethodGet,
    GXRequestMethodPost,
    GXRequestMethodPut,
    GXRequestMethodDelete
};

typedef NS_ENUM(NSInteger,GXParametersType){
    GXParametersTypeText,
    GXParametersTypeJson
};

@property (nonatomic,strong) NSURLSessionDataTask * dataTask;

/**
 发起GET请求
 读取
 
 @param host 主机url
 @param headers 请求头
 @param finished 成功回调
 @param failed 失败回调
 */
- (GXSessionRequest *)GETWithHost:(NSString *)host headers:(NSDictionary *)headers timeoutInterval:(float)time finished:(void (^)(NSURLResponse * response,NSData * responseData))finished failed:(void (^) (NSURLResponse * response,NSData * responseData))failed;

/**
 发起POST请求
 增添
 
 @param host 主机url
 @param headers 请求头
 @param parameters 请求体
 @param finished 成功回调
 @param failed 失败回调
 */
- (GXSessionRequest *)POSTWithHost:(NSString *)host headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters timeoutInterval:(float)time finished:(void (^)(NSURLResponse * response,NSData * responseData))finished failed:(void (^) (NSURLResponse * response,NSData * responseData))failed;

/**
 发起PUT请求
 
 @param host 主机url
 @param headers 请求头
 @param parameters 请求体
 @param finished 成功回调
 @param failed 失败回调
 */
- (GXSessionRequest *)PUTWithHost:(NSString *)host headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters timeoutInterval:(float)time finished:(void (^)(NSURLResponse * response,NSData * responseData))finished failed:(void (^) (NSURLResponse * response,NSData * responseData))failed;

/**
 发起DELETE请求
 
 @param host 主机url
 @param headers 请求头
 @param finished 成功回调
 @param failed 失败回调
 */
- (GXSessionRequest *)DELETEWithHost:(NSString *)host headers:(NSDictionary *)headers timeoutInterval:(float)time finished:(void (^)(NSURLResponse * response,NSData * responseData))finished failed:(void (^) (NSURLResponse * response,NSData * responseData))failed;

@end

NS_ASSUME_NONNULL_END
