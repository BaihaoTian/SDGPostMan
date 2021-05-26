//
//  SDGPostMan+XQDataCenter.m
//  SDGPostMan
//
//  Created by Bc.whi1te_Lei on 2018/10/18.
//

#import "SDGPostMan+XQDataCenter.h"

/*
 * 确定是由哪个target接受方法  接收的target分类 命名规则 为 Target_(target名字 原则上首字母大写 不包括括号)
 */
NSString *const kSDGPostManXQDataCenterTarget = @"XQDataCenter";
/*
 * 确定是由target调用哪个selector  selector的命名规则为 Action_(selector名  不包括括号)
 */
NSString *const kSDGPostManXQDataCenterOpenApp= @"nativeXQDataCenterOpenApp";
NSString *const kSDGPostManXQDataCenterCloseApp= @"nativeXQDataCenterCloseApp";
NSString *const kSDGPostManXQDataCenterOpenPage= @"nativeXQDataCenterOpenPage";
NSString *const kSDGPostManXQDataCenterLeavePage= @"nativeXQDataCenterLeavePage";
NSString *const kSDGPostManXQDataCenterClickEvent= @"nativeXQDataCenterClickEvent";
NSString *const kSDGPostManXQDataCenterClickInPage= @"nativeXQDataCenterClickInPage";
NSString *const kSDGPostManXQDataCenterClickAToB= @"nativeXQDataCenterClickAToB";

@implementation SDGPostMan (XQDataCenter)
#pragma mark - app event
/**
 增加打开app埋点
 
 @param otherParams 其余参数
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterOpenApp:(NSDictionary *)otherParams {
    [self performTarget:kSDGPostManXQDataCenterTarget
                  action:kSDGPostManXQDataCenterOpenApp
                 params:@{@"otherParams":otherParams?:@""}];
}

/**
 增加关闭app埋点
 
 @param page 关闭页面时所在vc字符串
 @param time 花费时间
 @param otherParams 其余参数
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterCloseAppAtPage:(NSString *)page spendTime:(NSString *)time params:(NSDictionary *)otherParams {
    [self performTarget:kSDGPostManXQDataCenterTarget
                  action:kSDGPostManXQDataCenterCloseApp
                 params:@{@"page":page?:@"",@"time":time?:@"",@"otherParams":otherParams?:@{}}];
}

#pragma mark - page event

/**
 增加打开页面埋点
 
 @param page 打开的页面
 @param refer 来源
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterOpenPage:(NSString *)page fromRefer:(NSString *)refer {
    [self performTarget:kSDGPostManXQDataCenterTarget
                  action:kSDGPostManXQDataCenterOpenPage
                  params:@{@"page":page?:@"",@"refer":refer?:@""}];
}

/**
 增加关闭页面的埋点
 
 @param page 当前的页面
 @param time 驻留时间
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterLeavePage:(NSString *)page spendTime:(NSString *)time {
    [self performTarget:kSDGPostManXQDataCenterTarget
                  action:kSDGPostManXQDataCenterLeavePage
                  params:@{@"page":page?:@"",@"time":time?:@""}];
}

#pragma mark - click event


/**
 增加埋点的点击事件
 
 @param uuid uuid为xpath的加密串
 @param spmContent spmcontent为下发的所带spm信息
 @param referVC referVC为点击时间发生的页面
 @param otherParam otherParam为基本用户信息
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterClickEventWithXpath:(NSString *)uuid spmContent:(NSDictionary *)spmContent referVC:(NSString *)referVC otherParam:(NSDictionary *)otherParam {
    NSDictionary *params =@{@"uuid":uuid?:@"",@"otherParam":otherParam?:@{},@"spmContent":spmContent?:@{},@"referVC":referVC?:@""};
    [self performTarget:kSDGPostManXQDataCenterTarget
                  action:kSDGPostManXQDataCenterClickEvent
                  params:params];
}



/**
 手动点击增加埋点
 
 @param currentSpm currentSpm为当前点击的spm信息
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterClickInPage:(NSString *)currentSpm {
    [self performTarget:kSDGPostManXQDataCenterTarget
                  action:kSDGPostManXQDataCenterClickInPage
                  params:@{@"currentSpm":currentSpm?:@""}];
}


/**
 页面间跳转埋点
 
 @param aUrl 当前页面aUrl
 @param bUrl 要打开的页面bUrl
 @param aSpm a携带的aSpm信息
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterClickA:(NSString *)aUrl ToB:(NSString *)bUrl withSpm:(NSString *)aSpm {
    [self performTarget:kSDGPostManXQDataCenterTarget
                  action:kSDGPostManXQDataCenterClickAToB
                  params:@{@"aUrl":aUrl?:@"",@"bUrl":bUrl?:@"",@"aSpm":aSpm?:@""}];
}
@end
