//
//  BaseViewModel.m
//  MVVMDemo
//
//  Created by 王海龙 on 2020/9/28.
//  Copyright © 2020 WHL. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (void)initWithBlock:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
    _successBlock = successBlock;
    _failBlock = failBlock;
}

@end
