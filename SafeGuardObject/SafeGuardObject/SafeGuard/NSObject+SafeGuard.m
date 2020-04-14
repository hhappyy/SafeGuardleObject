//
//  NSObject+SafeGuard.m
//  SafeGuardObject
//
//  Created by hapy on 2020/4/14.
//  Copyright © 2020 hapy. All rights reserved.
//

#import "NSObject+SafeGuard.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

#pragma mark -- array safeGuard

@implementation NSArray (SafeGuard)

+ (void)load {
    //load once
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //replace objectAtIndex
        NSString *tmpStr = @"objectAtIndex:";
        NSString *tmpFirstStr = @"safe_zeroObjectAtIndex:";
        NSString *tmpThreeStr = @"safe_objectAtIndex:";
        NSString *tmpSecondStr = @"safe_singleObjectAtIndex:";
        
        // replace objectAtIndexedSubscript
        NSString *tmpSubscriptStr = @"objectAtIndexedSubscript:";
        NSString *tmpSecondSubscriptStr = @"safe_objectAtIndexedSubscript:";
        
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSArray0")
                                 originalSelector:NSSelectorFromString(tmpStr)
                                safeGuardSelector:NSSelectorFromString(tmpFirstStr)];
        
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSSingleObjectArrayI")
                                 originalSelector:NSSelectorFromString(tmpStr)
                                safeGuardSelector:NSSelectorFromString(tmpSecondStr)];
        
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSArrayI")
                                 originalSelector:NSSelectorFromString(tmpStr)
                                safeGuardSelector:NSSelectorFromString(tmpThreeStr)];
        
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSArrayI")
                                 originalSelector:NSSelectorFromString(tmpSubscriptStr)
                                safeGuardSelector:NSSelectorFromString(tmpSecondSubscriptStr)];
    });
}


/// objectAtIndex       __NSArrayI
/// @param index index
- (id)safe_objectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        return nil;
    }
    return [self safe_objectAtIndex:index];
}


/// singleObjectAtIndex      __NSSingleObjectArrayI
/// @param index index
- (id)safe_singleObjectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        return nil;
    }
    return [self safe_singleObjectAtIndex:index];
}



/// zeroObjectAtIndex        __NSArray0
/// @param index index
- (id)safe_zeroObjectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        return nil;
    }
    return [self safe_zeroObjectAtIndex:index];
}


/// objectAtIndexedSubscript        __NSArrayI
/// @param idx index
- (id)safe_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count){
        return nil;
    }
    return [self safe_objectAtIndexedSubscript:idx];
}


@end

@implementation NSMutableArray (SafeGuard)

+ (void)load {
    //load once
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //replace objectAtIndex:
        NSString *originIndexSELStr = @"objectAtIndex:";
        NSString *safeGuardIndexSELStr = @"safeGuard_objectAtIndex:";
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSArrayM")
                                 originalSelector:NSSelectorFromString(originIndexSELStr)
                                safeGuardSelector:NSSelectorFromString(safeGuardIndexSELStr)];
        
        //replace removeObjectsInRange:
        NSString *originRemoveSELStr = @"removeObjectsInRange:";
        NSString *safeGuardRemoveSELStr = @"safeGuard_removeObjectsInRange:";
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSArrayM")
                                 originalSelector:NSSelectorFromString(originRemoveSELStr)
                                safeGuardSelector:NSSelectorFromString(safeGuardRemoveSELStr)];
        
        
        //replace insertObject:atIndex:
        NSString *tmpInsertStr = @"insertObject:atIndex:";
        NSString *tmpSafeInsertStr = @"safeGuard_insertObject:atIndex:";
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSArrayM")
                                 originalSelector:NSSelectorFromString(tmpInsertStr)
                                safeGuardSelector:NSSelectorFromString(tmpSafeInsertStr)];
        
        //replace removeObject:inRange:
        NSString *tmpRemoveRangeStr = @"removeObject:inRange:";
        NSString *tmpSafeRemoveRangeStr = @"safeGuard_removeObject:inRange:";
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSArrayM")
                                 originalSelector:NSSelectorFromString(tmpRemoveRangeStr)
                                safeGuardSelector:NSSelectorFromString(tmpSafeRemoveRangeStr)];
        
        
        // replace objectAtIndexedSubscript
        NSString *tmpSubscriptStr = @"objectAtIndexedSubscript:";
        NSString *tmpSecondSubscriptStr = @"safeGuard_objectAtIndexedSubscript:";
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSArrayM")
                                originalSelector:NSSelectorFromString(tmpSubscriptStr)
                                safeGuardSelector:NSSelectorFromString(tmpSecondSubscriptStr)];
    });
}



/// objectAtIndex
/// @param index index
- (id)safeGuard_objectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        return nil;
    }
    return [self safeGuard_objectAtIndex:index];
}



/// removeObjectsInRange
/// @param range range
- (void)safeGuard_removeObjectsInRange:(NSRange)range {
    
    if (range.location > self.count) {
        return;
    }
    
    if (range.length > self.count) {
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        return;
    }
    
    return [self safeGuard_removeObjectsInRange:range];
}



/// removeObject
/// @param anObject object
/// @param range range
- (void)safeGuard_removeObject:(id)anObject inRange:(NSRange)range {
    if (range.location > self.count) {
        return;
    }
    
    if (range.length > self.count) {
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        return;
    }
    
    if (!anObject){
        return;
    }
    return [self safeGuard_removeObject:anObject inRange:range];
}



/// insertObject
/// @param anObject object
/// @param index index
- (void)safeGuard_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > self.count) {
        return;
    }
    
    if (!anObject){
        return;
    }
    
    [self safeGuard_insertObject:anObject atIndex:index];
}



/// objectAtIndexedSubscript
/// @param idx startedIndex
- (id)safeGuard_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count){
        return nil;
    }
    return [self safeGuard_objectAtIndexedSubscript:idx];
}

@end



#pragma mark -- dictionary safeGuard

@implementation NSDictionary (SafeGuard)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *method = @"initWithObjects:forKeys:count:";
        NSString *systemClassStr = @"__NSPlaceholderDictionary";
        NSString *safeGuardMethodStr = @"initWithObjects_safeGuard:forKeys:count:";
        NSString *targetClassStr = @"NSDictionary";
        [self exchangeMethod:method
           systemClassString:systemClassStr
      safeGuuardMethodString:safeGuardMethodStr
           targetClassString:targetClassStr];
    });
}

- (instancetype)initWithObjects_safeGuard:(id *)objects forKeys:(id<NSCopying> *)keys count:(NSUInteger)count {
    NSUInteger rightCount = 0;
    for (NSUInteger i = 0; i < count; i++) {
        if (!(keys[i] && objects[i])) {
            break;
        }else{
            rightCount++;
        }
    }
    self = [self initWithObjects_safeGuard:objects forKeys:keys count:rightCount];
    return self;
}
@end


@implementation NSMutableDictionary (SafeGuard)

+ (void)load {
    //load once
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // replace removeObjectForKey:
        NSString *tmpRemoveStr = @"removeObjectForKey:";
        NSString *tmpSafeRemoveStr = @"safeGuard_removeObjectForKey:";
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSDictionaryM")
                                 originalSelector:NSSelectorFromString(tmpRemoveStr)
                                safeGuardSelector:NSSelectorFromString(tmpSafeRemoveStr)];
        
        // replace setObject:forKey:
        NSString *tmpSetStr = @"setObject:forKey:";
        NSString *tmpSafeSetRemoveStr = @"safeGuard_setObject:forKey:";
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSDictionaryM")
                                 originalSelector:NSSelectorFromString(tmpSetStr)
                                safeGuardSelector:NSSelectorFromString(tmpSafeSetRemoveStr)];
    });
}


/// removeObjectForKey
/// @param aKey key
- (void)safeGuard_removeObjectForKey:(id<NSCopying>)aKey {
    if (!aKey) {
        return;
    }
    [self safeGuard_removeObjectForKey:aKey];
}


/// setObject:forKey
/// @param anObject obj
/// @param aKey key
- (void)safeGuard_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject) {
        return;
    }
    if (!aKey) {
        return;
    }
    return [self safeGuard_setObject:anObject forKey:aKey];
}

@end


#pragma mark -- string safeGuard
@implementation NSMutableString (SafeGuard)


+ (void)load {
    //load once
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // replace  substringFromIndex:
        NSString *tmpSubFromStr = @"substringFromIndex:";
        NSString *tmpSafeSubFromStr = @"safeGuard_substringFromIndex:";
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpSubFromStr)
                                    safeGuardSelector:NSSelectorFromString(tmpSafeSubFromStr)];
        
        // replace  substringToIndex:
        NSString *tmpSubToStr = @"substringToIndex:";
        NSString *tmpSafeSubToStr = @"safeGuard_substringToIndex:";
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpSubToStr)
                                    safeGuardSelector:NSSelectorFromString(tmpSafeSubToStr)];
        
        // replace  substringWithRange:
        NSString *tmpSubRangeStr = @"substringWithRange:";
        NSString *tmpSafeSubRangeStr = @"safeGuard_substringWithRange:";
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpSubRangeStr)
                                    safeGuardSelector:NSSelectorFromString(tmpSafeSubRangeStr)];
        
        // replace  rangeOfString:options:range:locale:
        NSString *tmpRangeOfStr = @"rangeOfString:options:range:locale:";
        NSString *tmpSafeRangeOfStr = @"safeGuard_rangeOfString:options:range:locale:";
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpRangeOfStr)
                                    safeGuardSelector:NSSelectorFromString(tmpSafeRangeOfStr)];
        
        // replace  appendString
        NSString *tmpAppendStr = @"appendString:";
        NSString *tmpSafeAppendStr = @"safeGuard_appendString:";
        [NSObject exchangeInstanceMethodWithClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpAppendStr)
                                    safeGuardSelector:NSSelectorFromString(tmpSafeAppendStr)];
    });
}


/// substringFromIndex
/// @param from  startedIndex
- (NSString *)safeGuard_substringFromIndex:(NSUInteger)from {
    if (from > self.length ) {
        return @"";
    }
    return [self safeGuard_substringFromIndex:from];
}


/// substringToIndex     __NSCFString
/// @param to  endOfIndex
- (NSString *)safeGuard_substringToIndex:(NSUInteger)to {
    if (to > self.length ) {
        return @"";
    }
    return [self safeGuard_substringToIndex:to];
}


/// rangeOfString    __NSCFString
/// @param searchString targetString
/// @param mask compareOptions
/// @param rangeOfReceiverToSearch range
/// @param locale local
- (NSRange)safeGuard_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(nullable NSLocale *)locale {
    if (!searchString) {
        searchString = self;
    }
    
    if (rangeOfReceiverToSearch.location > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    if (rangeOfReceiverToSearch.length > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    if ((rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length) > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    
    return [self safeGuard_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
}


/// substringWithRange    __NSCFString
/// @param range range
- (NSString *)safeGuard_substringWithRange:(NSRange)range {
    if (range.location > self.length) {
        return @"";
    }
    
    if (range.length > self.length) {
        return @"";
    }
    
    if ((range.location + range.length) > self.length) {
        return @"";
    }
    return [self safeGuard_substringWithRange:range];
}



/// appendString    __NSCFString
/// @param aString appendedString
- (void)safeGuard_appendString:(NSString *)aString {
    if (!aString) {
        return;
    }
    return [self safeGuard_appendString:aString];
}
@end

