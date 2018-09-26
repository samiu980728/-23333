//
//  main.m
//  急急急算器
//
//  Created by 萨缪 on 2018/9/26.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaculatorBrain.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        CaculatorBrain * cacu = [[CaculatorBrain alloc] init];
        [cacu createNumAndSymobl];
    }
    return 0;
}
