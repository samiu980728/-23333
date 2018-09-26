//
//  CaculatorBrain.h
//  急急急算器
//
//  Created by 萨缪 on 2018/9/26.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorBrain : NSObject

@property (nonatomic, strong) NSMutableArray * numMutArray;

@property (nonatomic, strong) NSMutableArray * symbolMutArray;

@property (nonatomic, strong) NSMutableArray * finalMutArray;

@property (nonatomic, strong) NSMutableArray * temporaryMutArray;

- (void)createNumAndSymobl;

@end
