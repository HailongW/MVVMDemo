//
//  MVVMViewModel.h
//  MVVMDemo
//
//  Created by 王海龙 on 2020/9/28.
//  Copyright © 2020 WHL. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVVMViewModel : BaseViewModel

@property (nonatomic, copy) NSString *contentKey;

- (void)loadData;

@end

NS_ASSUME_NONNULL_END
