//
//  SDGPostManDetector.m
//  ServicesDispatchCenter
//
//  Created by Bc.whi1te_Lei on 2018/10/15.
//  Copyright © 2018 Bc.whi1te_Lei. All rights reserved.
//

#import "SDGPostManDetector.h"
#import "SDGPostMan.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "SDGPostManHeader.h"


typedef NS_ENUM(NSUInteger, SDGPostManDetectorErrorType) {
    SDGPostManDetectorErrorTypeResponderNotRespond,//响应库_目标targer存在 但是没有响应
    SDGPostManDetectorErrorTypeResponderNotFoundTarget,//响应库_目标target不存在
    SDGPostManDetectorErrorTypeWrapperDefineError,//wrapper_方法名定义不对
};

//TODO:TODO 暂时没有对入参和出参类型的检查
@interface SDGPostManDetector()
@property (nonatomic, strong) NSMutableArray<NSString *> *invaildList;
@end

@implementation SDGPostManDetector
//修改了接口同步策略 暂时不用检测
//+ (void)load {
//    __weak NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            dispatch_queue_t queue = dispatch_queue_create("SDGPostManDetectorQueue", DISPATCH_QUEUE_CONCURRENT);
//            dispatch_async(queue, ^{
//                SDGPostManDetector *instance = [[SDGPostManDetector alloc]init];
//                NSLog(@"-当前线程-------%@",[NSThread currentThread]);      // 打印当前线程
//                [instance runTests];
//            });
//
//            [center removeObserver:observer];
//        });
//    }];
//}



- (void)runTests {
#ifdef DEBUG
    unsigned int count;
    Method *methods = class_copyMethodList([SDGPostMan class], &count);
    
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        if ([name hasPrefix:@"SDGPostMan"]) {
            
            NSString *targetName = [self p_getTargetNameFromAction:name];
            NSString *actionName = [self p_getResponderRealMethodNameFromAction:name];
            
            if (targetName && targetName.length != 0 && actionName && actionName.length != 0) {
                
                Class target = NSClassFromString([NSString stringWithFormat:@"Target_%@",targetName]);
                SEL action = NSSelectorFromString(actionName);
                
                if (class_respondsToSelector(target,action)) {
                    /**
                     *对应的target能够响应selector 没有问题
                    */
                }else {
                    if (!target) {
                        [self.invaildList addObject:[self p_buildErrorMessageWithTarget:[NSString stringWithFormat:@"Target_%@",targetName] selector:actionName errType:SDGPostManDetectorErrorTypeResponderNotFoundTarget]];
                    }else {
                         [self.invaildList addObject:[self p_buildErrorMessageWithTarget:NSStringFromClass(target) selector:actionName errType:SDGPostManDetectorErrorTypeResponderNotRespond]];
                    }
                }
            }else {
              [self.invaildList addObject:[self p_buildErrorMessageWithTarget:targetName selector:name errType:SDGPostManDetectorErrorTypeWrapperDefineError]];
            }
        }
    }
    //UI 操作需要在主线程
    if (self.invaildList && self.invaildList.count != 0) {
        [self performSelectorOnMainThread:@selector(p_alert) withObject:nil waitUntilDone:nil];
    }
#else
#endif
}

#pragma mark - setter && getter
- (NSMutableArray<NSString *> *)invaildList {
    if (!_invaildList) {
        _invaildList = [NSMutableArray array];
    }
    return _invaildList;
}

#pragma mark - private method
//通过中间件方法名获取应该响应的targetName
//SDGPostMan_Test_GetDictionary --> Test
- (NSString *)p_getTargetNameFromAction:(NSString *)actionName {
    if (![actionName containsString:@"_"]) {
        return nil;
    }
    NSString *str = [actionName substringFromIndex: [actionName rangeOfString:@"_"].location + 1];
    if (![str containsString:@"_"]) {
        return nil;
    }
    str = [str substringToIndex:[str rangeOfString:@"_"].location];
    return str;
}

//通过中间件方法名获取应该响应的selectorName
//SDGPostMan_Test_GetDictionary --> Action_nativeGetDictionary
- (NSString *)p_getResponderRealMethodNameFromAction:(NSString *)actionName {
    if (![actionName containsString:@"_"]) {
        return nil;
    }
    NSString *str = [actionName substringFromIndex: [actionName rangeOfString:@"_"].location + 1];
    if (![str containsString:@"_"]) {
        return nil;
    }
    str = [str substringFromIndex:[str rangeOfString:@"_"].location + 1];
    //最后根据规则增加前缀
    str = [NSString stringWithFormat:@"Action_native%@",str];
    return str;
    
}

//构建错误消息
- (NSString *)p_buildErrorMessageWithTarget:(NSString *)targetName selector:(NSString *)selector errType:(SDGPostManDetectorErrorType)errorType{
    switch (errorType) {
        case SDGPostManDetectorErrorTypeResponderNotFoundTarget:{
            return [NSString stringWithFormat:@"响应库-目标target（%@）没找到，请检查\n",targetName];
            break;
        }
        case SDGPostManDetectorErrorTypeResponderNotRespond:{
            return [NSString stringWithFormat:@"响应库-目标target（%@）中的 method（%@）没找到，请检查\n",targetName,selector];
            break;
        }
        case SDGPostManDetectorErrorTypeWrapperDefineError:{
            return [NSString stringWithFormat:@"SDGPostMan-目标target（%@）中的 method（%@）定义符合规则，请检查\n",targetName?:@"?",selector];
            
            break;
        }
        default:
            break;
    }
    return nil;
}

- (void)p_alert {
    NSMutableString * invaildStr = [NSMutableString string];
    for (NSString *invaild in self.invaildList) {
        [invaildStr appendString:invaild];
    }
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:NSLocalizedString(@"警告", nil)
                                           message:[invaildStr copy]
                                   preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:NSLocalizedString(@"去解决", nil)
                             style:UIAlertActionStyleCancel
                           handler:nil];
    [alertController addAction:cancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:NO completion:nil];
}
@end
