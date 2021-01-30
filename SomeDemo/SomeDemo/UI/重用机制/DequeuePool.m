//
//  DequeuePool.m
//  SomeDemo
//
//  Created by 孙虎林 on 2021/1/30.
//

#import "DequeuePool.h"

@interface DequeuePool()
/// 从多少个开始复用
@property (nonatomic, assign) NSInteger dequeueCount;

/// pool
///  identifier: 等待重用对象
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSMutableSet *> *pool;

// identifier - class
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSString *> *identifierClassDict;

@end

@implementation DequeuePool

+(instancetype)defaultPool {
    DequeuePool *pool = [[DequeuePool alloc] init];
    pool.dequeueCount = 3;
    return  pool;
}

/// UI的操作都在主线程，这里不考虑线程问题
- (void)registerClass:(nullable Class)Class forReuseIdentifier:(NSString *)identifier {
    if ([Class isKindOfClass:[UIViewCube class]]) {
        NSAssert(YES, @"类型注册错误");
        return;
    }
    if ([self.identifierClassDict.allKeys containsObject:identifier]) {
        // 已经注册过了
        return;;
    }
    NSString *classStr = NSStringFromClass(Class);
    self.identifierClassDict[identifier] = classStr;
    self.pool[identifier] = [NSMutableSet set];
}

- (nullable __kindof UIViewCube *)dequeueReusableWithIdentifier:(NSString *)identifier {
    if (identifier.length == 0) {
        return  [[UIViewCube alloc] init];
    }
    // 先从缓存池中拿，如果缓存池中没有，那么创建新的之后，在放入缓存池
    // 重用池
    NSMutableSet *cubes = self.pool[identifier];
    /// 对应的class
    NSString *classStr = self.identifierClassDict[identifier];
    NSLog(@"%@",cubes);
    if (cubes.count < self.dequeueCount) {
        // 创建一个新的
        UIViewCube *cube = [[NSClassFromString(classStr) alloc] init];
        [cubes addObject:cube];
        NSLog(@"开始创建 %p",cube);
        return cube;
    } else {
        // 返回
        UIViewCube *cube = [cubes anyObject];
        NSLog(@"重用了 %p",cube);
        return cube;
    }
    return  [[UIViewCube alloc] init];
}

-(void)dealloc {
    NSLog(@"DequeuePool 兄弟我释放了");
}

-(NSMutableDictionary<NSString *,NSMutableSet *> *)pool {
    if (_pool == nil) {
        _pool = [NSMutableDictionary dictionary];
    }
    return  _pool;
}

-(NSMutableDictionary<NSString *,NSString *> *)identifierClassDict {
    if (_identifierClassDict == nil) {
        _identifierClassDict = [NSMutableDictionary dictionary];
    }
    return  _identifierClassDict;
}

@end
