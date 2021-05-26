//
//  SDGPostMan+XQAppmonitor.m
//  SDGPostMan
//
//  Created by Bc.whi1te_Lei on 2018/10/18.
//

#import "SDGPostMan+XQAppmonitor.h"

/*
 * 确定是由哪个target接受方法  接收的target分类 命名规则 为 Target_(target名字 原则上首字母大写 不包括括号)
 */
NSString *const kSDGPostManXQAppmonitorTarget = @"XQAppmonitor";
/*
 * 确定是由target调用哪个selector  具体实现的selector的命名规则为 Action_(selector名  不包括括号)
 */
NSString *const kSDGPostManAppMonitorUpdateUserPhone= @"nativeAppMonitorUpdateUserPhone";
NSString *const kSDGPostManAppMonitorSetAppType= @"nativeAppMonitorSetAppType";
NSString *const kSDGPostManAppMonitorTraceEvent= @"nativeAppMonitorTraceEvent";
NSString *const kSDGPostManAppMonitorFlushCount= @"nativeAppMonitorFlushCount";
NSString *const kSDGPostManAppMonitorflushEventArray= @"nativeAppMonitorflushEventArray";
NSString *const kSDGPostManAppMonitorEventResetHeader= @"nativeAppMonitorEventResetHeader";

@implementation SDGPostMan (XQAppmonitor)

/**
 update user phone for appmonitor
 
 @param phone 用户电话
 */
- (void)SDGPostMan_XQAppmonitor_AppMonitorUpdateUserPhone:(NSString *)phone {
    [self performTarget:kSDGPostManXQAppmonitorTarget
                  action:kSDGPostManAppMonitorUpdateUserPhone
                 params:@{@"phone":phone?:@""}];

}


/**
 set apptypr for appmonitor
 
 @param appType appType
 */
- (void)SDGPostMan_XQAppmonitor_AppMonitorSetAppType:(NSString *)appType {
    [self performTarget:kSDGPostManXQAppmonitorTarget
                  action:kSDGPostManAppMonitorSetAppType
                 params:@{@"appType":appType?:@""}];
}


/**
 增加埋点
 
 @param userInfo 埋点信息
 */
- (void)SDGPostMan_XQAppmonitor_AppMonitorTraceEvent:(NSDictionary *)userInfo {
    [self performTarget:kSDGPostManXQAppmonitorTarget
                  action:kSDGPostManAppMonitorTraceEvent
                 params:@{@"userInfo":userInfo?:@{}}];
}


/**
 重置埋点计数
 */
- (void)SDGPostMan_XQAppmonitor_AppMonitorFlushCount {
    [self performTarget:kSDGPostManXQAppmonitorTarget
                  action:kSDGPostManAppMonitorFlushCount
                  params:nil];
}

/**
 重置埋点储存组
 */
- (void)SDGPostMan_XQAppmonitor_AppMonitorflushEventArray {
    [self performTarget:kSDGPostManXQAppmonitorTarget
                  action:kSDGPostManAppMonitorflushEventArray
                  params:nil];
}


/**
 resetHeader
 */
- (void)SDGPostMan_XQAppmonitor_AppMonitorEventResetHeader {
    [self performTarget:kSDGPostManXQAppmonitorTarget
                  action:kSDGPostManAppMonitorEventResetHeader
                  params:nil];
}
@end
