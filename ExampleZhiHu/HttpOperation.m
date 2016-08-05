//
//  HttpOperation.m
//  ExampleZhiHu
//
//  Created by Aries on 16/4/9.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "HttpOperation.h"

@implementation HttpOperation

+ (void)getRequestWithURL:(NSString *)URLString parameters:(id)parameters success:(successBlock)success failure:(failureBlock)failure {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kbaseURL]];
    [manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
