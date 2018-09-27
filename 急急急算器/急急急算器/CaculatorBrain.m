//
//  CaculatorBrain.m
//  急急急算器
//
//  Created by 萨缪 on 2018/9/26.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "CaculatorBrain.h"
#include "stdlib.h"
@implementation CaculatorBrain

- (void)createNumAndSymobl
{
    //_numMutArray = [[NSMutableArray alloc] init];
    //_symbolMutArray = [[NSMutableArray alloc] init];
    
    _finalMutArray = [[NSMutableArray alloc] init];
    _temporaryMutArray = [[NSMutableArray alloc] init];
    //入栈
    //把textField.text 传入进来 或者 分别在那个UI界面 设置 数组 把textField.text里面的所有内容先进行判定 如果是符号 则传入一个数组 是数字则传入另一个数组 在点击 = 号的时候执行即可
    _numMutArray = [NSMutableArray arrayWithObjects:@1,@2,@3,@5,@4, nil];
    _symbolMutArray = [NSMutableArray arrayWithObjects:@"+",@"(",@"+",@"+",@")",@"*", nil];
    
    int flagAdd = 0;
    int flagSubtraction = 0;
    int flagMultiplication = 1;
    int flagdivision = 1;
    
    int leftBracket = 2;
    int x = 0;
    int rightBracket = 2;
    
    int flagBracket = 0;
    int flagNum = 0;
    int flagSymbol = 0;
    
    int inNum = 0;
    int inSymbol = 0;
    
    for (int i = 0; i < _symbolMutArray.count; i++) {
        NSString * ifBracketStr = [NSString stringWithFormat:@"%@",_symbolMutArray[i]];
        if ( [ifBracketStr isEqualToString:@"("] ){
            flagBracket = 1;
            break;
        }
    }
    //这样先遍历一下 计算 数字与运算符各有几个
    flagNum = [[NSNumber numberWithInteger:_numMutArray.count] intValue];
    flagSymbol = [[NSNumber numberWithInteger:_symbolMutArray.count] intValue];
    
    NSLog(@"flagNum =  %d    flagSymbol = %d ",flagNum,flagSymbol);
    //这是没有括号的情况  运算符总是比数字少一个
    if ( flagBracket == 0 ){
    for (int i = 0; i < _numMutArray.count+_symbolMutArray.count; i++) {
        //入栈规矩：如果是加号 减号 直接入栈 如果是乘法 除法 那就把栈中之前的一个数字和数字数组中下一个数字进行 * 或者 / 的运算
        if ( inNum < flagNum ){
            [_temporaryMutArray addObject:[NSNumber numberWithInteger:[_numMutArray[i] integerValue]]];
            inNum++;
        }
        
//        if ( i < _numMutArray.count-1 ){
//            [_temporaryMutArray addObject:_symbolMutArray[i]];
//        }
        if ( inSymbol < flagSymbol ){
            [_temporaryMutArray addObject:_symbolMutArray[i]];
            inSymbol++;
        }
    }
        inNum = 0;
        inSymbol = 0;
        NSLog(@"------------");
    }
    
    
    
    //有括号的情况 运算符比数字多一个 并且 入栈方式也是 先判定左括号 左括号上一个肯定也必须是运算符
    //再判定右括号，右括号的右边肯定也要运算符入栈
    else if ( flagBracket == 1 ){
        NSString * ifBracketStr1;
        NSString * nextStr;
        
        //NSLog(@"_numMutArray = %@",_numMutArray);
        //NSLog(@"_symbolMutArray = %@",_symbolMutArray);
        for (int i = 0; i < _symbolMutArray.count+_numMutArray.count; i++) {
            if ( inSymbol < flagSymbol ){
                ifBracketStr1 = [NSString stringWithFormat:@"%@",_symbolMutArray[inSymbol]];
                if ( i > 0 ){
                nextStr = [NSString stringWithFormat:@"%@",_temporaryMutArray[i-1]];
                    NSLog(@"nextStr === %@",nextStr);
                    NSLog(@"asdasdsadas i ==== %d",i);
                }
            }
            
            if ( [ifBracketStr1 isEqualToString:@"("] ){
                [_temporaryMutArray addObject:_symbolMutArray[inSymbol]];
                inSymbol++;
            }
            
            //右括号的判定 有一些问题 ！！！！
            //这里 嘚删除！！！
//            else if ([ifBracketStr1 isEqualToString:@")"] && ( ![nextStr isEqualToString:@"+"] || ![nextStr isEqualToString:@"-"] || ![nextStr isEqualToString:@"*"] || ![nextStr isEqualToString:@"/"])){
//                NSLog(@" i =%d 执行 右括号进入   ----- ",i);
//                [_temporaryMutArray addObject:_symbolMutArray[inSymbol]];
//                inSymbol++;
//            }
            else{
                NSLog(@" i = %d  还需要对她进行判断--------",i);
                //NSLog(@"_numMutArray[i] = %@",_numMutArray[i]);
            if ( inNum < flagNum ){
                //NSLog(@"进去了   -- -- inNum = %d  \n_numMutArray[%d] = %@",inNum,inNum,_numMutArray[inNum]);
                
                
                
                //这里有问题  [_numMutArray[inNum] integerValue]  要进去的是inNum 不是 i 界值
                [_temporaryMutArray addObject:[NSNumber numberWithInteger:[_numMutArray[inNum] integerValue]]];
                NSLog(@"加入 Num的 _temporaryMutArray = %@",_temporaryMutArray);
                inNum++;
            }
            
            if ([ifBracketStr1 isEqualToString:@")"] && ( ![nextStr isEqualToString:@"+"] || ![nextStr isEqualToString:@"-"] || ![nextStr isEqualToString:@"*"] || ![nextStr isEqualToString:@"/"]) && inSymbol < flagSymbol){
                NSLog(@" i =%d 执行 右括号进入   ----- ",i);
                [_temporaryMutArray addObject:_symbolMutArray[inSymbol]];
                inSymbol++;
            }
                
                //这里要加  并且_symbolMutArray[inSymbol] ！= 右括号！！！！！！！！！！
            if ( inSymbol < flagSymbol ){
                [_temporaryMutArray addObject:_symbolMutArray[inSymbol]];
                //NSLog(@"进去了   -- -- inSymbol = %d  \n[_symbolMutArray[%d] = %@",inSymbol,inSymbol,_symbolMutArray[inSymbol]);
                //NSLog(@"进去了   -- -- inSymbol = %d  ",inSymbol);
                NSLog(@"加入 symbol的 _temporaryMutArray = %@",_temporaryMutArray);
                inSymbol++;
            }
    }
        }
    }
    
    int flagBye = 0;
    NSLog(@"赋值完毕后的_temporaryMutArray = %@",_temporaryMutArray);
    
    for (int i = 0; i < _temporaryMutArray.count; i++) {
        NSString * stringAll = [NSString stringWithFormat:@"%@",_temporaryMutArray[i]];
        //NSLog(@"stringAll = %@",stringAll);
        if ( ([stringAll isEqualToString:@"*"] || [stringAll isEqualToString:@"/"]) ){
            //两种可能 一种是前面有括号的 一种是前面没有括号的
            NSLog(@"进去啦 stringAll = %@",stringAll);
            NSString * string1 = [NSString stringWithFormat:@"%@",_temporaryMutArray[i-2]];
            
            NSString * string2 = [NSString stringWithFormat:@"%@",_temporaryMutArray[i]];
            
            NSString * bracketStr = [NSString stringWithFormat:@"%@",_temporaryMutArray[i-1]];
            
            if ( [string1 isEqualToString:@"+"] || [string1 isEqualToString:@"-"] ){
//                NSString * string2 = [NSString stringWithFormat:@"%@",_temporaryMutArray[i]];
//
//                NSString * bracketStr = [NSString stringWithFormat:@"%@",_temporaryMutArray[i-1]];
                
                NSLog(@"终于进去啦---------");
                if ( [string2 isEqualToString:@"*"] ){
                    x = [_temporaryMutArray[i-1] intValue] * [_temporaryMutArray[i+1] intValue];
                    _temporaryMutArray[i-1] = [NSNumber numberWithInt:x];
                    
                    [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInt:i] integerValue]];
                    //[_temporaryMutArray removeObject:_temporaryMutArray[i]];
                    //flagBye++;
                    NSLog(@"被移除的_temporaryMutArray[i+1] = %@      x = %d",_temporaryMutArray[i],x);
                    [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInt:i] integerValue]];
                    //flagBye++;
                }
                else if ([string2 isEqualToString:@"/"]){
                    x = [_temporaryMutArray[i-1] intValue] / [_temporaryMutArray[i+1] intValue];
                    _temporaryMutArray[i-1] = [NSNumber numberWithInt:x];
                    
                    
                    [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInt:i] integerValue]];
                   // flagBye++;
                    [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInt:i] integerValue]];
                   // flagBye++;
                }
            }
            
            //还有一种有括号的
            NSLog(@"再次检验赋值完毕后的_temporaryMutArray = %@",_temporaryMutArray);
            
//            NSLog(@"1222222bracketStr = %@  i = %d  00000",bracketStr,i);
//            NSLog(@"_temporaryMutArray[%d] = %@",i,_temporaryMutArray[i]);
//            NSLog(@"_temporaryMutArray[%d] = %@",i-1,_temporaryMutArray[i-1]);
            if ( [bracketStr isEqualToString:@")"] ){
                rightBracket = i-1;
                NSLog(@"有括号的------进去了");
                for (int j = 0; j < i-1; j++) {
                    NSString * string3 = [NSString stringWithFormat:@"%@",_temporaryMutArray[j]];
                    if ( [string3 isEqualToString:@"("] ){
                        leftBracket = j;
                        NSLog(@"左括号的位置  leftBracket =    %d",leftBracket);
                        break;
                    }
                }
//                for (int j = 0; j < i-1; j++) {
//                    NSString * string3 = [NSString stringWithFormat:@"%@",_temporaryMutArray[j]];
//                    if ( [string3 isEqualToString:@")"] ){
//                        rightBracket = j;
//
//                        NSLog(@"有啦----------");
//                        break;
//                    }
//                }
                NSLog(@"此时 i = %d",i);
                
                //找到左括号 对左括号和右括号 i 之间的进行遍历
                for (int j = leftBracket; j < rightBracket; ) {
                    NSString * string3;
                    if ( j <= _temporaryMutArray.count-1 ){
                    string3 = [NSString stringWithFormat:@"%@",_temporaryMutArray[j]];
                    }
                    if ( [string3 isEqualToString:@"+"] ){
                        x = [_temporaryMutArray[j-1] intValue] + [_temporaryMutArray[j+1] intValue];
                        _temporaryMutArray[j-1] = [NSNumber numberWithInt:x];
                        
                        NSLog(@"这时的 _temporaryMutArray[%d+1] ===  %@",j,_temporaryMutArray[j+1]);
                        
                        [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInt:j+1] integerValue]];
                        //[_temporaryMutArray removeObject:_temporaryMutArray[j+1]];
                        flagBye++;
                        
                        NSLog(@"这时的 数组 = %@",_temporaryMutArray);
                        
                        NSLog(@"移除一个之后的 _temporaryMutArray[%d] ===  %@",j,_temporaryMutArray[j]);
                        [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInt:j] integerValue]];
                        flagBye++;
                        //[_temporaryMutArray removeObject:_temporaryMutArray[j]];
                        //还要移除 左右 括号 最后再移除？
                        //[_temporaryMutArray removeObject:_temporaryMutArray[leftBracket]];
                        
                        NSLog(@"移除完毕之后的 数组 = %@",_temporaryMutArray);
                        
                    }
                    else if ( [string3 isEqualToString:@"-"] ){
                        x = [_temporaryMutArray[j-1] intValue] - [_temporaryMutArray[j+1] intValue];
                        _temporaryMutArray[j-1] = [NSNumber numberWithInt:x];
                        
                        [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInteger:j+1] integerValue]];
                        //[_temporaryMutArray removeObject:_temporaryMutArray[j+1]];
                        flagBye++;
                        
                        [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInteger:j] integerValue]];
                        //[_temporaryMutArray removeObject:_temporaryMutArray[j]];
                        flagBye++;
                    }else{
                        j++;
                        NSLog(@"j = %d",j);
                    }
                }
                NSLog(@"移除括号之前  _temporaryMutArray = %@",_temporaryMutArray);
                
                
                //还要移除 左右 括号 最后再移除？
                NSLog(@"移除左   括号时 _temporaryMutArray[%d] = %@",leftBracket,_temporaryMutArray[leftBracket]);
                NSLog(@"移除右   括号时 _temporaryMutArray[%d] = %@",rightBracket-flagBye,_temporaryMutArray[rightBracket-flagBye]);
                
                [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInteger:rightBracket-flagBye] integerValue]];
                //[_temporaryMutArray removeObject:_temporaryMutArray[rightBracket-flagBye]];
                flagBye++;
                
                [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInteger:leftBracket] integerValue]];
                //[_temporaryMutArray removeObject:_temporaryMutArray[leftBracket]];
                flagBye++;
                
                NSLog(@"flagBBye = %d\n   i = %d",flagBye,i);
                
                i -= flagBye + 1;
            }
        }
        //上面就全部遍历完了 然后里面的符号就都剩加减号
        //        if ( (_temporaryMutArray[i] isEqualToString:@"+" || [_temporaryMutArray[i] isEqualToString:@"-") && )
        
    }
    
    NSLog(@"只剩加减法的数组-----_temporaryMutArray = %@",_temporaryMutArray);
    
    for (int i = 0; i < _temporaryMutArray.count; ) {
       // NSLog(@"每次取出好好好的 _temporaryMutArray = %@",_temporaryMutArray);
        NSString * stringAll = [NSString stringWithFormat:@"%@",_temporaryMutArray[i]];
        //NSLog(@"stringAll = %@",stringAll);
        //NSLog(@"最后的   stringAll = %@",stringAll);
        if ( [stringAll isEqualToString:@"+"] ){
            x = [_temporaryMutArray[i-1] intValue] + [_temporaryMutArray[i+1] intValue];
            _temporaryMutArray[i-1] = [NSNumber numberWithInt:x];
            
            [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInteger:i] integerValue]];
            
            //[_temporaryMutArray removeObject:_temporaryMutArray[i]];
            flagBye++;
            
            [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInteger:i] integerValue]];
            //[_temporaryMutArray removeObject:_temporaryMutArray[i]];
            flagBye++;
        }
        
//        NSLog(@"i ======= %d",i);
//        NSLog(@"_temporaryMutArray[%d] = %@",i,_temporaryMutArray[i]);
//        NSLog(@"stringAll = %@",stringAll);
        else if ( [stringAll isEqualToString:@"-"] ){
            NSLog(@"战时的stringAll = %@",stringAll);
            x = [_temporaryMutArray[i-1] intValue] - [_temporaryMutArray[i+1] intValue];
            _temporaryMutArray[i-1] = [NSNumber numberWithInt:x];
            NSLog(@"需要移除----iii = %d",i);
            
            [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInteger:i] integerValue]];
            //[_temporaryMutArray removeObject:_temporaryMutArray[i]];
            flagBye++;
            
            [_temporaryMutArray removeObjectAtIndex:[[NSNumber numberWithInteger:i] integerValue]];
            //[_temporaryMutArray removeObject:_temporaryMutArray[i]];
            flagBye++;
            
        }else{
            i++;
        }
    }
    NSLog(@"最终结果为：%@  x = %d",_temporaryMutArray,x);
}

@end
