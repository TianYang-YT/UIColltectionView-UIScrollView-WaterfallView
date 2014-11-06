//
//  YTHttpManager.h
//  DICM
//
//  Created by 杨天 on 14-10-27.
//  Copyright (c) 2014年 杨 天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//数据请求完成的block
typedef void (^AFFinishedBlcok) (AFHTTPRequestOperation *operation, id responseObj);

typedef void (^AFFailedBlock) (AFHTTPRequestOperation *operation, NSError *error);

@interface YTHttpManager : NSObject
/**
 *  单例
 */
+ (YTHttpManager *)shareManager;

/**
 *  GET请求
 *
 *  @param URLString GET请求地址
 */
+ (void)GET:(NSString *)URLString finished:(AFFinishedBlcok)finished failed:(AFFailedBlock)failed;

/**
 *  POST请求,参数是字典形式的
 *
 *  @param URLString POST请求地址
 *  @param dic       参数字典
 */
+ (void)POST:(NSString *)URLString parameters:(NSDictionary *)dic finished:(AFFinishedBlcok)finished failed:(AFFailedBlock)failed;

/**
 *  取消当前所有请求
 */
- (void)cancelAllRequests;

/**
 *  判断网络环境的方法,传递归来一个blcok
 */
- (void)netStatus:(void(^)(AFNetworkReachabilityStatus status))statusBlock;
@end
