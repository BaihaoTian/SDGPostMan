//
//  SDGPostMan+XQTriggerKit.m
//  SDGPostMan
//
//  Created by Bc.whi1te_Lei on 2018/10/16.
//

#import "SDGPostMan+XQTriggerKit.h"

/*
 * 确定是由哪个target接受方法  接收的target分类 命名规则 为 Target_(target名字 原则上首字母大写 不包括括号)
 */
NSString *const kSDGPostManXQTriggerKitTarget = @"XQTriggerKit";
/*
 * 确定是由target调用哪个selector  selector的命名规则为 Action_(selector名  不包括括号)
 */
NSString *const kSDGPostManXQTriggerManagerUploadDataInfoDic = @"nativeXQTriggerManagerUploadDataInfoDic";
NSString *const kSDGPostManXQTriggerManagerShowDebugList = @"nativeXQTriggerManagerShowDebugList";
NSString *const kSDGPostManXQTriggerKitGetViewControllerUrl = @"nativeXQTriggerKitGetViewControllerUrl";


@implementation SDGPostMan (XQTriggerKit)
/**
 获取埋点最新所需的信息

 @return 返回获取到的基本信息
 */
- (NSDictionary *)SDGPostMan_XQTriggerKit_XQTriggerManagerUploadDataInfoDic {
    return [self performTarget:kSDGPostManXQTriggerKitTarget
                        action:kSDGPostManXQTriggerManagerUploadDataInfoDic
                        params:nil];
}

/**
 ShowDebugList
 */
- (void)SDGPostMan_XQTriggerKit_XQTriggerManagerShowDebugList {
    [self performTarget:kSDGPostManXQTriggerKitTarget
                 action:kSDGPostManXQTriggerManagerShowDebugList
                 params:nil];
}

/**
 获取VC的url
 
 @param params <#params description#>
 @return <#return value description#>
 */
- (NSString *)SDGPostMan_XQTriggerKit_XQTriggerKitGetViewControllerUrl:(NSString *)VCStr {
    return [self performTarget:kSDGPostManXQTriggerKitTarget
                        action:kSDGPostManXQTriggerKitGetViewControllerUrl
                        params:@{@"viewController":VCStr?:@""}];
}
@end
