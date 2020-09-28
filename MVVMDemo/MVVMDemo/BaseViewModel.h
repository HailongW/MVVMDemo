//
//  BaseViewModel.h
//  MVVMDemo
//
//  Created by 王海龙 on 2020/9/28.
//  Copyright © 2020 WHL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessBlock)(id data);
typedef void(^FailBlock)(id data);

@interface BaseViewModel : NSObject

@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailBlock failBlock;

- (void)initWithBlock:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

@end

NS_ASSUME_NONNULL_END
