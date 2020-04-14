//
//  NSObject+Swizzle.h
//  SafeGuardObject
//
//  Created by hapy on 2020/4/14.
//  Copyright © 2020 hapy. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzle)


/// exchange imp
/// @param systemMethodString system classname
/// @param systemClassString system method
/// @param safeMethodString custom method
/// @param targetClassString target class
+ (void)exchangeMethod:(NSString *)systemMethodString
     systemClassString:(NSString *)systemClassString
    safeGuuardMethodString:(NSString *)safeMethodString
     targetClassString:(NSString *)targetClassString;


///  exchange two methods
/// @param selfClass class type
/// @param originalSelector origin method
/// @param safeSelector exchanged method
+ (void)exchangeInstanceMethodWithClass:(Class)selfClass
                       originalSelector:(SEL)originalSelector
                      safeGuardSelector:(SEL)safeSelector;



@end

NS_ASSUME_NONNULL_END
