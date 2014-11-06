//
//  YTHttpManager.m
//  DICM
//
//  Created by 杨天 on 14-10-27.
//  Copyright (c) 2014年 杨 天. All rights reserved.
//

#import "YTHttpManager.h"

@implementation YTHttpManager

static YTHttpManager *manager = nil;
+ (YTHttpManager *)shareManager {
    static dispatch_once_t once;
    //一次只允许一个线程访问
    dispatch_once(&once, ^{
        if (manager == nil) {
            manager = [[YTHttpManager alloc] init];
        }
    });
    return manager;
}

/**
 *  请求地址,参数字典,请求完成和是失败后的回调
 */
+ (void)POST:(NSString *)URLString parameters:(NSDictionary *)dic finished:(AFFinishedBlcok)finished failed:(AFFailedBlock)failed {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置接收的服务器数据格式
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/xml", @"text/plain", @"application/xml", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //post请求, 并将两个block做个参数,manager没执行一次请求方法 都会自动创建一个NSOperation,并将operation加到了OperationQueue中
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:URLString parameters:dic success:finished failure:failed];
}

/**
 *  GET请求
 *
 *  @param URLString GET请求地址
 */
+ (void)GET:(NSString *)URLString finished:(AFFinishedBlcok)finished failed:(AFFailedBlock)failed {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置接收的服务器数据格式
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URLString parameters:nil success:finished failure:failed];
}

/**
 *  取消当前所有请求,在vc的dealloc方法中调用,防止数据请求下来之前vc已经销毁而造成崩溃
 */
- (void)cancelAllRequests {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (manager.operationQueue.operationCount) {
        //通过queue取消请求
        [manager.operationQueue cancelAllOperations];
    }
}

/**
 *  判断网络环境的方法(3G/WiFi/其他),传递归来一个blcok
 */
- (void)netStatus:(void(^)(AFNetworkReachabilityStatus status))statusBlock {
    //AFNetworkReachabilityManager 能够检测网络环境和状态
    //开启网络检测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //调用网络状态方法,传进block参数
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:statusBlock];
}

/**
 *   typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
 *      AFNetworkReachabilityStatusUnknown          = -1,
 *      AFNetworkReachabilityStatusNotReachable     = 0,
 *      AFNetworkReachabilityStatusReachableViaWWAN = 1, //运营商网络(G,E,2G,3G,4G...)
 *      AFNetworkReachabilityStatusReachableViaWiFi = 2, //WiFi网络/以太网
 *   };
 */
@end