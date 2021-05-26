//
//  SDGPostMan+XqPr1vacyUtil.m
//  XQPr1vacyUtil
//
//  Created by Bc.whi1te_Lei on 2018/10/16.
//

#import "SDGPostMan+XQPr1vacyUtil.h"

/*
 * 确定是由哪个target接受方法  接收的target分类 命名规则 为 Target_(target名字 原则上首字母大写 不包括括号)
 */
NSString *const kSDGPostManXQPr1vacyUtilTarget = @"XQPr1vacyUtil";
/*
 * 确定是由target调用哪个selector  selector的命名规则为 Action_(selector名 不包括括号)
 */
NSString *const kSDGPostManXQPr1vacyUtilShowPr1vacyUtilWithName = @"nativeShowPr1vacyUtilWithName";

@implementation SDGPostMan (XQPr1vacyUtil)

- (void)SDGPostMan_XQPr1vacyUtil_ShowPr1vacyUtilWithName:(NSString *)name {
    [self performTarget:kSDGPostManXQPr1vacyUtilTarget
                 action:kSDGPostManXQPr1vacyUtilShowPr1vacyUtilWithName
                 params:@{@"name":name?:@""}];
}
@end
