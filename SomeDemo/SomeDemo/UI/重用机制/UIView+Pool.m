//
//  UIView+Pool.m
//  SomeDemo
//
//  Created by 孙虎林 on 2021/1/30.
//

#import "UIView+Pool.h"
#import <objc/runtime.h>

static NSString *const kDequeuePoolKey;

@implementation UIView (Pool)

- (void)registerClass:(nullable Class)Class forReuseIdentifier:(NSString *)identifier {
    if (self.dequeuePool == nil) {
        self.dequeuePool = [DequeuePool defaultPool];
    }
    [self.dequeuePool registerClass:Class forReuseIdentifier:identifier];
}

- (nullable __kindof UIViewCube *)dequeueReusableWithIdentifier:(NSString *)identifier {
    if (self.dequeuePool == nil) {
        NSAssert(true, @"方法调用错误，没有先注册");
    }
    return [self.dequeuePool dequeueReusableWithIdentifier:identifier];
}

@end


@implementation UIView (Dequeue)

-(void)setDequeuePool:(DequeuePool *)dequeuePool {
    objc_setAssociatedObject(self, &kDequeuePoolKey, dequeuePool, OBJC_ASSOCIATION_RETAIN);
}

- (DequeuePool *)dequeuePool {
    return objc_getAssociatedObject(self, &kDequeuePoolKey);
}

@end
