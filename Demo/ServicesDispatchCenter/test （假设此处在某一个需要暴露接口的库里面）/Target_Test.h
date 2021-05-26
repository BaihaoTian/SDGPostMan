//
//  Target_TestMediator.h
//  ServicesDispatchCenter
//
//  Created by Bc.whi1te_Lei on 2018/9/21.
//  Copyright © 2018 Bc.whi1te_Lei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Target_Test : NSObject
- (NSDictionary *)Action_nativeGetDictionary:(NSDictionary *)params;

- (void)Action_nativeInvokeBlock:(NSDictionary *)params;

- (UIViewController *)Action_nativeGetController:(NSDictionary *)params;
@end

