//
//  DequeuePool.h
//  SomeDemo
//
//  Created by 孙虎林 on 2021/1/30.
//

#import <Foundation/Foundation.h>
#import "UIViewCube.h"
#import "DequeuePool.h"

NS_ASSUME_NONNULL_BEGIN

///  重用池 . 内部约定，超过三个就开始重用
@interface DequeuePool : NSObject

+(instancetype)defaultPool;

- (void)registerClass:(nullable Class)Class forReuseIdentifier:(NSString *)identifier;

- (nullable __kindof UIViewCube *)dequeueReusableWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
