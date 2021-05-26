//
//  SDGPostMan.m
//  ServicesDispatchCenter
//
//  Created by Bc.whi1te_Lei on 2018/9/21.
//  Copyright © 2018 Bc.whi1te_Lei. All rights reserved.
//

#import "SDGPostMan.h"

static SDGPostMan *_sharedInstance = nil;

static NSString *error_TAG = @"SDGPostMan";
#define SDGPostManLog(info) \
NSLog(@"[%@--reportError:%@]",error_TAG,info);


@interface SDGPostMan ()
@property (nonatomic, strong) NSMutableDictionary *cachedTarget;
@end

@implementation SDGPostMan


+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        //because has rewrited allocWithZone  use NULL avoid endless loop lol.
        _sharedInstance = [[super allocWithZone:NULL] init];
    });
    return _sharedInstance;
}


- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params {
    NSString *targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
    NSString *actionString = [NSString stringWithFormat:@"Action_%@:", actionName];
    
    
    NSObject *target = self.cachedTarget[targetClassString];
    if (target == nil) {
        Class targetClass = NSClassFromString(targetClassString);
        target = [[targetClass alloc] init];
    }
    
    SEL action = NSSelectorFromString(actionString);
    
    if (target == nil) {
        NSString *errorInfo = [NSString stringWithFormat:@"target (%@) is not exist",targetName];
        SDGPostManLog(errorInfo)
        return nil;
    }
    if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored    "-Warc-performSelector-leaks"
        return [self safePerformAction:action target:target params:params];
#pragma clang diagnostic pop
    } else {
        SEL errorAction = NSSelectorFromString(@"notFound:");
        
        if ([target respondsToSelector:errorAction]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            return [self safePerformAction:errorAction target:target params:params];
//            return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
        }else {
            [self.cachedTarget removeObjectForKey:targetClassString];
            NSString *errorInfo = [NSString stringWithFormat:@"target(%@) not perform action(%@)",targetName,actionName];
            SDGPostManLog(errorInfo)
#ifdef DEBUG
            [self p_alert:errorInfo];
#else
#endif
            return nil;
        }
    }
}


- (void)releaseCachedTargetWithTargetName:(NSString *)targetName
{
    NSString *targetClassString = [NSString stringWithFormat:@"Target_%@", targetName];
    [self.cachedTarget removeObjectForKey:targetClassString];
}


- (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params {
    //获取方法签名
    NSMethodSignature* methodSig = [target methodSignatureForSelector:action];
    if(methodSig == nil) {
        return nil;
    }
    const char* retType = [methodSig methodReturnType];
    
    if (strcmp(retType, @encode(void)) == 0) {
        //获取方法签名对应的invocation
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        //设置参数
        [invocation setArgument:&params atIndex:2];
        /**设置要执行的selector。与[invocation setArgument:action atIndex:1] 等价*/
        [invocation setSelector:action];
        /**
         设置消息接受者，与[invocation setArgument:(__bridge void * _Nonnull)(target) atIndex:0]等价
         */
        [invocation setTarget:target];
        [invocation invoke];
        return nil;
    }
    
    if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(BOOL)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(CGFloat)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setTarget:target];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
}


#pragma mark - getters and setters
- (NSMutableDictionary *)cachedTarget
{
    if (_cachedTarget == nil) {
        _cachedTarget = [[NSMutableDictionary alloc] init];
    }
    return _cachedTarget;
}

#pragma mark - private method
- (void)p_alert:(NSString *)errorMessage {
#ifdef DEBUG
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:NSLocalizedString(@"警告", nil)
                                        message:errorMessage
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction =
    [UIAlertAction actionWithTitle:NSLocalizedString(@"去解决", nil)
                             style:UIAlertActionStyleCancel
                           handler:nil];
    [alertController addAction:cancelAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:NO completion:nil];
#else
#endif
}



#pragma mark - rewrite method
+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [SDGPostMan sharedInstance];
}

+ (instancetype)alloc
{
    return [SDGPostMan sharedInstance];
}

- (id)copy
{
    return self;
}

- (id)mutableCopy
{
    return self;
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return self;
}
@end
