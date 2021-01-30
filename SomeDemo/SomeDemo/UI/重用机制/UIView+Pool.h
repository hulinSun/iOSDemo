//
//  UIView+Pool.h
//  SomeDemo
//
//  Created by 孙虎林 on 2021/1/30.
//

#import <UIKit/UIKit.h>
#import "UIViewCube.h"
#import "DequeuePool.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Pool)

- (void)registerClass:(nullable Class)Class forReuseIdentifier:(NSString *)identifier;

- (nullable __kindof UIViewCube *)dequeueReusableWithIdentifier:(NSString *)identifier;

@end

/// 关联一个复用池
@interface UIView (Dequeue)
@property (nonatomic, strong) DequeuePool *dequeuePool;
@end


NS_ASSUME_NONNULL_END
