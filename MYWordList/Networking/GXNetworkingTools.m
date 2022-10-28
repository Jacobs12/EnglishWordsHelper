//
//  GXNetworkingTools.m
//  EWangMedia
//
//  Created by wolffy on 2021/2/3.
//  Copyright © 2021 北京光线传媒股份有限公司. All rights reserved.
//

#import "GXNetworkingTools.h"
//#import "SSKeychain.h"
//#import "NSString+MD5.h"

#ifdef DEBUG
#define KEYCHAIN_SERVICE @"com.xiankan.XKVideo"//域名
#else
#define KEYCHAIN_SERVICE @"com.xiankan.video"//域名
#endif

#define KEYCHAIN_UUID_ACCOUNT @"KEYCHAIN_UUID"//账号

@interface GXNetworkingTools ()

@end

@implementation GXNetworkingTools

+ (NSString *)getUrlWithHost:(NSString *)host queryParameters:(NSDictionary *)query{
    NSMutableString * result = [[NSMutableString alloc]init];
    [result appendString:[NSString stringWithFormat:@"%@",host]];
    if(query == nil || query.allKeys.count == 0){
        return result;
    }
//    添加?
    BOOL isExist = [result containsString:@"?"];
    if(isExist == NO){
        [result appendString:@"?"];
    }
    for(NSInteger i=0;i<query.allKeys.count;i++){
        @try {
            NSString * key = query.allKeys[i];
            if([result containsString:[NSString stringWithFormat:@"%@=",key]]){
                continue;
            }
            if(isExist == NO && i == 0){
                
            }else{
                [result appendString:@"&"];
            }
            NSString * value = query[key];
            [result appendString:[NSString stringWithFormat:@"%@=%@",key,value]];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    return result;
}

+ (NSDictionary *)publicQueryParameters{
//    NSString * version = [NSString stringWithFormat:@"%@",[GXAppInfo appVersion]];
//    NSString * mid = [[GXNetworkingTools getUniqueId] calcMD5];
//    NSString * xkuc = @"";
//    NSString * token = [EWUserInfo defaultManager].token;
//    if([GXUtils isAvailableString:token]){
//        xkuc = [GXUtils urlEncodeWithString:token];
//    }
    NSDictionary * result = @{
//        @"ch":@"AppStore",
//        @"mid":mid,
//        @"platform":@"iPhone",
//        @"vr":version,
//        @"xkuc":xkuc,
//        @"ss":@"3"
    };
    return result;
}

//获取设备的唯一Id
+ (NSString *)getUniqueId{
//    NSError *_error = nil;
//    NSString *retrieveuuid = [SSKeychain passwordForService:KEYCHAIN_SERVICE account:KEYCHAIN_UUID_ACCOUNT error:&_error];
//
//    if (!retrieveuuid || [retrieveuuid isEqualToString:@""]) {
//        CFUUIDRef uuid = CFUUIDCreate(NULL);
//        assert(uuid != NULL);
//
//        retrieveuuid = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuid));
//        [SSKeychain setPassword: [NSString stringWithFormat:@"%@", retrieveuuid]
//                     forService:KEYCHAIN_SERVICE account:KEYCHAIN_UUID_ACCOUNT];
//    }
    
//    return retrieveuuid;
    return @"";
}

@end
