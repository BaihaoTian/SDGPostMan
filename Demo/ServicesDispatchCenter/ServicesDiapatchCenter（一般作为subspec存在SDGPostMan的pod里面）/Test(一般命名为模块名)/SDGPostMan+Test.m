//
//  SDGPostMan+test.m
//  ServicesDispatchCenter
//
//  Created by Bc.whi1te_Lei on 2018/9/21.
//  Copyright © 2018 Bc.whi1te_Lei. All rights reserved.
//

#import "SDGPostMan+Test.h"

/*
 * 确定是由哪个target接受方法  接收的target分类 命名规则 为 Target_(target名字 原则上首字母大写 不包括括号)
 * 以当前为例子  实现接口的类名为 Target_Test
 */
NSString *const kSDGPostManTestTarget = @"Test";
/*
 * 确定是由target调用哪个selector  selector的命名规则为 Action_(selector名 原则上首字母小写 不包括括号)
 * 以当前为例子  实现接口的selector名为 Action_nativeGetDictionary
 */
NSString *const kSDGPostManTestGetDictionary = @"nativeGetDictionary";
NSString *const kSDGPostManTestInvokeBlock = @"nativeInvokeBlock";
NSString *const kSDGPostManTestGetController = @"nativeGetController";


@implementation SDGPostMan (Test)


- (NSDictionary *)SDGPostMan_Test_GetDictionary:(NSDictionary *)params {
    return [self performTarget:kSDGPostManTestTarget action:kSDGPostManTestGetDictionary params:params];
}

- (void)SDGPostMan_Test_InvokeBlock:(void(^)(NSString *code))handle {
    [self performTarget:kSDGPostManTestTarget action:kSDGPostManTestInvokeBlock params:@{@"handle":handle}];
}

- (UIViewController *)SDGPostMan_Test_GetController:(NSDictionary *)params {
    return [self performTarget:kSDGPostManTestTarget action:kSDGPostManTestGetController params:params];
}

@end
