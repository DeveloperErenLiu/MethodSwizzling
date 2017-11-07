//
//  ViewController.m
//  Swizzling-Demo
//
//  Created by 刘小壮 on 16/8/30.
//  Copyright © 2016年 刘小壮. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 
     在本文中对NSArray进行了Swizzling，实现了NSArray异常操作的崩溃拦截功能。本篇文章只是简单的写了一下，主要是为了介绍Method Swizzling这个知识点。等以后有时间，会根据这个思路写一个崩溃拦截系统。
     
     备注：为了方便调试过程中及时发现问题，建议只在线上版本使用这个功能，在测试阶段不要开启，以便及时发现并处理问题。
     */
    
    // 测试代码
    NSArray *array = @[@0, @1, @2, @3];
    [array objectAtIndex:3];
    [array objectAtIndex:4];
}

@end
