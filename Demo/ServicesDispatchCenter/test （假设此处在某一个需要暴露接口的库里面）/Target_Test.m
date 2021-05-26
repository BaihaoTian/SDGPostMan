//
//  Target_TestMediator.m
//  ServicesDispatchCenter
//
//  Created by Bc.whi1te_Lei on 2018/9/21.
//  Copyright © 2018 Bc.whi1te_Lei. All rights reserved.
//

#import "Target_Test.h"
#import "TestViewController.h"

@implementation Target_Test
- (NSDictionary *)Action_nativeGetDictionary:(NSDictionary *)params {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:params];
    [dic setValue:@"test" forKey:@"key"];
    return [dic copy];
}

- (void)Action_nativeInvokeBlock:(NSDictionary *)params {
    void(^callBack)(NSString *info) = params[@"handle"];
    callBack(@"block invoke");
//    handle(@"block invoke");
}

- (UIViewController *)Action_nativeGetController:(NSDictionary *)params {
    TestViewController *vc = [[TestViewController alloc]init];
    return vc;
}
@end
