//
//  CaculatorBrain.m
//  急急急算器
//
//  Created by 萨缪 on 2018/9/26.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "CaculatorBrain.h"

@implementation CaculatorBrain

- (void)createNumAndSymobl
{
    //_numMutArray = [[NSMutableArray alloc] init];
    //_symbolMutArray = [[NSMutableArray alloc] init];
    
    _finalMutArray = [[NSMutableArray alloc] init];
    _temporaryMutArray = [[NSMutableArray alloc] init];
    //入栈
    //把textField.text 传入进来 或者 分别在那个UI界面 设置 数组 把textField.text里面的所有内容先进行判定 如果是符号 则传入一个数组 是数字则传入另一个数组 在点击 = 号的时候执行即可
    _numMutArray = [NSMutableArray arrayWithObjects:@1,@2,@3,@4, nil];
    _symbolMutArray = [NSMutableArray arrayWithObjects:@"+",@"*",@"-", nil];
    
    int flagAdd = 0;
    int flagSubtraction = 0;
    int flagMultiplication = 1;
    int flagdivision = 1;
    
    int leftBracket = 2;
    int x = 0;
    int rightBracket = 2;
    
    for (int i = 0; i < _numMutArray.count; i++) {
        //入栈规矩：如果是加号 减号 直接入栈 如果是乘法 除法 那就把栈中之前的一个数字和数字数组中下一个数字进行 * 或者 / 的运算
        if ( _numMutArray[i] != nil ){
            [_temporaryMutArray addObject:[NSNumber numberWithInteger:[_numMutArray[i] integerValue]]];
        }
        if ( i < _numMutArray.count-1 ){
            [_temporaryMutArray addObject:_symbolMutArray[i]];
        }
        
    }
    
    NSLog(@"赋值完毕后的_temporaryMutArray = %@",_temporaryMutArray);
    
    for (int i = 0; i < _temporaryMutArray.count; i++) {
        NSString * stringAll = [NSString stringWithFormat:@"%@",_temporaryMutArray[i]];
        NSLog(@"stringAll = %@",stringAll);
        if ( ([stringAll isEqualToString:@"*"] || [stringAll isEqualToString:@"/"]) ){
            //两种可能 一种是前面有括号的 一种是前面没有括号的
            NSLog(@"进去啦 stringAll = %@",stringAll);
            if ( [_temporaryMutArray[i-2] isEqualToString:@"+"] || [_temporaryMutArray[i-2] isEqualToString:@"-"] ){
                
                NSLog(@"终于进去啦---------");
                if ( [_temporaryMutArray[i] isEqualToString:@"*"] ){
                    x = [_temporaryMutArray[i-1] intValue] * [_temporaryMutArray[i+1] intValue];
                    _temporaryMutArray[i-1] = [NSNumber numberWithInt:x];
                    [_temporaryMutArray removeObject:_temporaryMutArray[i]];
                    
                    NSLog(@"被移除的_temporaryMutArray[i+1] = %@      x = %d",_temporaryMutArray[i],x);
                    [_temporaryMutArray removeObject:_temporaryMutArray[i]];
                }
                else if ([_temporaryMutArray[i] isEqualToString:@"/"]){
                    x = [_temporaryMutArray[i-1] intValue] / [_temporaryMutArray[i+1] intValue];
                    _temporaryMutArray[i-1] = [NSNumber numberWithInt:x];
                    [_temporaryMutArray removeObject:_temporaryMutArray[i]];
                    [_temporaryMutArray removeObject:_temporaryMutArray[i]];
                }
            }
            
            //还有一种有括号的
            if ( [_temporaryMutArray[i-2] isEqualToString:@")"] ){
                for (int j = 0; j < i-2; j++) {
                    if ( [_temporaryMutArray[j] isEqualToString:@"("] ){
                        leftBracket = j;
                        break;
                    }
                }
                //找到左括号 对左括号和右括号 i 之间的进行遍历
                for (int j = leftBracket; j < i-2; j++) {
                    if ( [_temporaryMutArray[j] isEqualToString:@"+"] ){
                        x = [_temporaryMutArray[j-1] intValue] + [_temporaryMutArray[j+1] intValue];
                        _temporaryMutArray[j-1] = [NSNumber numberWithInt:x];
                        [_temporaryMutArray removeObject:_temporaryMutArray[j]];
                        [_temporaryMutArray removeObject:_temporaryMutArray[j]];
                    }
                }
            }
        }
        //上面就全部遍历完了 然后里面的符号就都剩加减号
        //        if ( (_temporaryMutArray[i] isEqualToString:@"+" || [_temporaryMutArray[i] isEqualToString:@"-") && )
        
    }
    
    NSLog(@"只剩加减法的数组-----_temporaryMutArray = %@",_temporaryMutArray);
    
    for (int i = 0; i < _temporaryMutArray.count; ) {
        NSLog(@"每次取出好好好的 _temporaryMutArray = %@",_temporaryMutArray);
        NSString * stringAll = [NSString stringWithFormat:@"%@",_temporaryMutArray[i]];
        //NSLog(@"stringAll = %@",stringAll);
        //NSLog(@"最后的   stringAll = %@",stringAll);
        if ( [stringAll isEqualToString:@"+"] ){
            x = [_temporaryMutArray[i-1] intValue] + [_temporaryMutArray[i+1] intValue];
            _temporaryMutArray[i-1] = [NSNumber numberWithInt:x];
            [_temporaryMutArray removeObject:_temporaryMutArray[i]];
            [_temporaryMutArray removeObject:_temporaryMutArray[i]];
        }
        
//        NSLog(@"i ======= %d",i);
//        NSLog(@"_temporaryMutArray[%d] = %@",i,_temporaryMutArray[i]);
//        NSLog(@"stringAll = %@",stringAll);
        else if ( [stringAll isEqualToString:@"-"] ){
            NSLog(@"战时的stringAll = %@",stringAll);
            x = [_temporaryMutArray[i-1] intValue] - [_temporaryMutArray[i+1] intValue];
            _temporaryMutArray[i-1] = [NSNumber numberWithInt:x];
            NSLog(@"需要移除----iii = %d",i);
            [_temporaryMutArray removeObject:_temporaryMutArray[i]];
            
            [_temporaryMutArray removeObject:_temporaryMutArray[i]];
            
        }else{
            i++;
        }
    }
    NSLog(@"最终结果为：%@  x = %d",_temporaryMutArray,x);
}

@end
