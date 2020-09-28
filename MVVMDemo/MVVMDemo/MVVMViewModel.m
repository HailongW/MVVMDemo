//
//  MVVMViewModel.m
//  MVVMDemo
//
//  Created by 王海龙 on 2020/9/28.
//  Copyright © 2020 WHL. All rights reserved.
//

#import "MVVMViewModel.h"

@implementation MVVMViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addObserver:self forKeyPath:@"contentKey" options:(NSKeyValueObservingOptionNew) context:nil];
    }
    return self;
}

- (void)loadData {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
         [NSThread sleepForTimeInterval:1];
         NSArray *array = @[@"宝马X7",@"奔驰S",@"奥迪Q8",@"布加迪",@"迈凯伦",@"劳斯莱斯",@"保时捷",@"法拉利"];
         dispatch_async(dispatch_get_main_queue(), ^{
             // 外面调用 封装的代码块 能够获取到我们给的数据 (及时性)
             self.successBlock(array);
         });
     });
}

#pragma mark -  KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSString *contentKey = change[NSKeyValueChangeNewKey];
    
    NSArray *array = @[@"宝马X7",@"奔驰S",@"奥迪Q8",@"布加迪",@"迈凯伦",@"劳斯莱斯",@"保时捷",@"法拉利"];
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:array];
    
    @synchronized (self) {
        [mArray removeObject:contentKey];
    }
    
    self.successBlock(mArray);

}


- (void)dealloc{
    
    [self removeObserver:self forKeyPath:@"contentKey"];
}

@end
