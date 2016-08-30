//
//  NSArray+LXZArray.m
//  Swizzling-Demo
//
//  Created by 刘小壮 on 16/8/30.
//  Copyright © 2016年 刘小壮. All rights reserved.
//

#import "NSArray+LXZArray.h"
#import <objc/runtime.h>

/** 
 在iOS中NSNumber、NSArray、NSDictionary等这些类都是类簇，一个NSArray的实现可能由多个类组成。
 所以如果想对NSArray进行Swizzling，必须获取到其“真身”进行Swizzling，直接对NSArray进行操作是无效的。
 
 下面列举了NSArray和NSDictionary本类的类名，可以通过Runtime函数取出本类。
 NSArray                __NSArrayI
 NSMutableArray         __NSArrayM
 NSDictionary           __NSDictionaryI
 NSMutableDictionary	__NSDictionaryM
 */

@implementation NSArray (LXZArray)

// Swizzling核心代码
// 需要注意的是，好多同学反馈下面代码不起作用，造成这个问题的原因大多都是其调用了super load方法。在下面的load方法中，不应该调用父类的load方法。
+ (void)load {
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(lxz_objectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
}

// 为了避免和系统的方法冲突，我一般都会在swizzling方法前面加前缀
- (id)lxz_objectAtIndex:(NSUInteger)index {
    // 判断下标是否越界，如果越界就进入异常拦截
    if (self.count-1 < index) {
        @try {
            return [self lxz_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息。如果是线上，可以在这里将崩溃信息发送到服务器
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    } // 如果没有问题，则正常进行方法调用
    else {
        return [self lxz_objectAtIndex:index];
    }
}

@end














