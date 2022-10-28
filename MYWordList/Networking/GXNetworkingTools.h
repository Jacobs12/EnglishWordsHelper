//
//  GXNetworkingTools.h
//  EWangMedia
//
//  Created by wolffy on 2021/2/3.
//  Copyright © 2021 北京光线传媒股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GXNetworkingTools : NSObject

/// 为host添加query参数
/// @param host host description
/// @param query query description
+ (NSString *)getUrlWithHost:(NSString *)host queryParameters:(NSDictionary *)query;

/// 公参
+ (NSDictionary *)publicQueryParameters;

//获取设备的唯一Id
+ (NSString *)getUniqueId;

@end

NS_ASSUME_NONNULL_END
