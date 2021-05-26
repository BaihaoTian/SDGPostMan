//
//  SDGPostMan+test.h
//  ServicesDispatchCenter
//
//  Created by Bc.whi1te_Lei on 2018/9/21.
//  Copyright © 2018 Bc.whi1te_Lei. All rights reserved.
//
#import "SDGPostMan.h"


@interface SDGPostMan (Test)

- (NSDictionary *)SDGPostMan_Test_GetDictionary:(NSDictionary *)params;

- (void)SDGPostMan_Test_InvokeBlock:(void(^)(NSString *code))handle;

- (UIViewController *)SDGPostMan_Test_GetController:(NSDictionary *)params;

@end
