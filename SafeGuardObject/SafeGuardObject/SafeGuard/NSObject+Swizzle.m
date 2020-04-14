//
//  NSObject+Swizzle.m
//  SafeGuardObject
//
//  Created by hapy on 2020/4/14.
//  Copyright © 2020 hapy. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>


@implementation NSObject (Swizzle)

+ (void)exchangeMethod:(NSString *)systemMethodString
     systemClassString:(NSString *)systemClassString
safeGuuardMethodString:(NSString *)safeMethodString
     targetClassString:(NSString *)targetClassString
{
    Method sysMethod = class_getInstanceMethod(NSClassFromString(systemClassString), NSSelectorFromString(systemMethodString));
    Method safeMethod = class_getInstanceMethod(NSClassFromString(targetClassString), NSSelectorFromString(safeMethodString));
    method_exchangeImplementations(safeMethod, sysMethod);
}

+ (void)exchangeInstanceMethodWithClass:(Class)selfClass
                       originalSelector:(SEL)originalSelector
                      safeGuardSelector:(SEL)safeSelector {
    
    Method originalMethod = class_getInstanceMethod(selfClass, originalSelector);
    Method safeGuardMethod = class_getInstanceMethod(selfClass, safeSelector);
    BOOL didAddMethod = class_addMethod(selfClass,
                                        originalSelector,
                                        method_getImplementation(safeGuardMethod),
                                        method_getTypeEncoding(safeGuardMethod));
    if (didAddMethod) {
        class_replaceMethod(selfClass,
                            safeSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, safeGuardMethod);
    }
}
@end
