//
//  ZZFoundationUtil.m
//  ZZFoundation
//
//  Created by Walker Stark on 10/23/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "ZZFoundationUtil.h"
@import ObjectiveC;

#pragma mark - File path util functions
#pragma mark -
NSString *ZZSearchPathForDocument(NSString *filePath)
{
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return [docDir stringByAppendingPathComponent:filePath];
}

NSString *ZZSearchPathForCache(NSString *filePath)
{
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    return [docDir stringByAppendingPathComponent:filePath];
}

NSString *ZZSearchPathForTemporary(NSString *filePath)
{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:filePath];
}


#pragma mark - Runtime util functions
#pragma mark -
NSArray<NSString *> *ZZClassSubClassNamesForClass(Class clazz)
{
    NSMutableArray<NSString *> *classArray = [NSMutableArray array];
    
    int classCount = objc_getClassList(NULL, 0);
    Class *classes = NULL;
    classes = (__unsafe_unretained Class*) malloc(sizeof(Class) * classCount);
    classCount = objc_getClassList(classes, classCount);
    for (int i = 0; i < classCount; i++) {
        Class aClass = classes[i];
        do {
            aClass = class_getSuperclass(aClass);
        } while(aClass && aClass != clazz);
        
        if (!aClass) continue;
        
        [classArray addObject:NSStringFromClass(classes[i])];
    }
    free(classes);
    
    return classArray;
}

FOUNDATION_EXPORT NSString *ZZClassPropertyDescriptionForObject(id object)
{
    NSMutableString *keyValueString = [NSMutableString string];
    void (^buildKeyValueString)(Class) = ^(Class cls) {
        unsigned int propertyCount = 0;
        objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
        for (NSUInteger i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            NSString *name = [NSString stringWithUTF8String:property_getName(property)];
            id value = @"<invalid>";
            char *propertyTypeStr = property_copyAttributeValue(property, "T");
            
            if (propertyTypeStr && strlen(propertyTypeStr) > 0) {
                char propertyType = propertyTypeStr[0];
                free(propertyTypeStr);
                
                switch (propertyType) {
                    case _C_SEL:
                    case _C_PTR: {
                        SEL getterSEL;
                        char *getterName = property_copyAttributeValue(property, "G");
                        if (getterName) {
                            getterSEL = sel_getUid(getterName);
                        } else {
                            getterSEL = NSSelectorFromString(name);
                        }
                        free(getterName);
                        
                        void *pointer = NULL;
                        if (class_isMetaClass(cls)) {
                            if ([object respondsToSelector:getterSEL]) {
                                pointer = ((SEL (*)(id, SEL))[cls instanceMethodForSelector:getterSEL])(object, getterSEL);
                            }
                        } else {
                            pointer = ((SEL (*)(id, SEL))[object methodForSelector:getterSEL])(object, getterSEL);
                        }
                        if (propertyType == _C_SEL) {
                            value = pointer ? NSStringFromSelector(pointer) : @"<no selector>";
                        } else if (propertyType == _C_PTR) {
                            value = [NSString stringWithFormat:@"%p", pointer];
                        }
                        break;
                    }
                        
                    case _C_VOID:
                        value = @"<void>";
                        break;
                        
                    case _C_UNDEF:
                        value = @"<undefined>";
                        break;
                        
                    default:
                        value = [object valueForKey:name];
                        break;
                }
            }
            
            // Transform to NSDate
            if ([value isKindOfClass:NSNumber.self] && [name.lowercaseString containsString:@"timestamp"]) {
                value = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
            }
            [keyValueString appendFormat:@"\t%@: %@,\n", name, value];
        }
        free(properties);
    };
    
    Class clazz = object_getClass(object);
    buildKeyValueString(clazz);
    
    Class superClazz;
    while(superClazz && superClazz != clazz) {
        superClazz = class_getSuperclass(clazz);
        buildKeyValueString(superClazz);
    }
    
    return [NSString stringWithFormat:@"<%@ %p> {\n%@}", NSStringFromClass([object class]), object, keyValueString];;
}

void ZZClassSwizzleMethod(Class clazz, SEL originalSelector, SEL swizzledSelector)
{
    // the method might not exist in the class, but in its superclass
    BOOL isClassMethod = class_isMetaClass(clazz);
    Method originalMethod = isClassMethod ? class_getClassMethod(clazz, originalSelector) : class_getInstanceMethod(clazz, originalSelector);
    Method swizzledMethod = isClassMethod ? class_getClassMethod(clazz, swizzledSelector) : class_getInstanceMethod(clazz, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL isSuccess = class_addMethod(clazz, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (isSuccess) {
        class_replaceMethod(clazz, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
