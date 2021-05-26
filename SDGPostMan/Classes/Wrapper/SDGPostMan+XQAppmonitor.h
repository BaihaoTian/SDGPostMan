//
//  SDGPostMan+XQAppmonitor.h
//  SDGPostMan
//
//  Created by Bc.whi1te_Lei on 2018/10/18.
//

#import "SDGPostMan.h"


@interface SDGPostMan (XQAppmonitor)

/**
 update user phone for appmonitor

 @param phone 用户电话
 */
- (void)SDGPostMan_XQAppmonitor_AppMonitorUpdateUserPhone:(NSString *)phone;


/**
 set apptypr for appmonitor

 @param appType appType
 */
- (void)SDGPostMan_XQAppmonitor_AppMonitorSetAppType:(NSString *)appType;


/**
 增加埋点

 @param userInfo 埋点信息
 */
- (void)SDGPostMan_XQAppmonitor_AppMonitorTraceEvent:(NSDictionary *)userInfo;


/**
 重置埋点计数
 */
- (void)SDGPostMan_XQAppmonitor_AppMonitorFlushCount;

/**
 重置埋点储存组
 */
- (void)SDGPostMan_XQAppmonitor_AppMonitorflushEventArray;


/**
 resetHeader
 */
- (void)SDGPostMan_XQAppmonitor_AppMonitorEventResetHeader;

@end


