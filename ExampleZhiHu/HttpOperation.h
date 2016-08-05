//
//  HttpOperation.h
//  ExampleZhiHu
//
//  Created by Aries on 16/4/9.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpOperation : NSObject
typedef void (^successBlock)(id responseObject);
typedef void (^failureBlock)(NSError *error);

+ (void)getRequestWithURL:(NSString *)URLString parameters:(nullable id)parameters success:(successBlock)success failure:(failureBlock)failure;

@end
