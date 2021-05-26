//
//  SDGPostMan+XQTriggerKit.h
//  SDGPostMan
//
//  Created by Bc.whi1te_Lei on 2018/10/16.
//

#import "SDGPostMan.h"


@interface SDGPostMan (XQTriggerKit)

/**
 获取埋点最新所需的信息
 
 @return 返回获取到的基本信息
 */

- (NSDictionary *)SDGPostMan_XQTriggerKit_XQTriggerManagerUploadDataInfoDic;


/**
 ShowDebugList
 */
- (void)SDGPostMan_XQTriggerKit_XQTriggerManagerShowDebugList;


/**
 获取VC的url

 @param VCStr VCStr description
 @return <#return value description#>
 */
- (NSString *)SDGPostMan_XQTriggerKit_XQTriggerKitGetViewControllerUrl:(NSString *)VCStr;
@end

