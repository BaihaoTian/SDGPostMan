//
//  SDGPostMan+XQDataCenter.h
//  SDGPostMan
//
//  Created by Bc.whi1te_Lei on 2018/10/18.
//

#import "SDGPostMan.h"


@interface SDGPostMan (XQDataCenter)
#pragma mark - app event
/**
 增加打开app埋点

 @param otherParams 其余参数
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterOpenApp:(NSDictionary *)otherParams;

/**
 增加关闭app埋点

 @param page 关闭页面时所在vc字符串
 @param time 花费时间
 @param otherParams 其余参数
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterCloseAppAtPage:(NSString *)page spendTime:(NSString *)time params:(NSDictionary *)otherParams;

#pragma mark - page event

/**
 增加打开页面埋点

 @param page 打开的页面
 @param refer 来源
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterOpenPage:(NSString *)page fromRefer:(NSString *)refer;

/**
 增加关闭页面的埋点

 @param page 当前的页面
 @param time 驻留时间
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterLeavePage:(NSString *)page spendTime:(NSString *)time;

#pragma mark - click event


/**
 增加埋点的点击事件

 @param uuid uuid为xpath的加密串
 @param spmContent spmcontent为下发的所带spm信息
 @param referVC referVC为点击时间发生的页面
 @param otherParam otherParam为基本用户信息
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterClickEventWithXpath:(NSString *)uuid spmContent:(NSDictionary *)spmContent referVC:(NSString *)referVC otherParam:(NSDictionary *)otherParam;



/**
 手动点击增加埋点

 @param currentSpm currentSpm为当前点击的spm信息
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterClickInPage:(NSString *)currentSpm;


/**
 页面间跳转埋点

 @param aUrl 当前页面aUrl
 @param bUrl 要打开的页面bUrl
 @param aSpm a携带的aSpm信息
 */
- (void)SDGPostMan_XQDataCenter_XQDataCenterClickA:(NSString *)aUrl ToB:(NSString *)bUrl withSpm:(NSString *)aSpm;
@end
