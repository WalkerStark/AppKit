//
//  NSUserDefaults+zz_foundation.m
//  zz_foundation
//
//  Created by Walker Stark on 10/24/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "NSUserDefaults+ZZFoundation.h"
#import "ZZFoundationUtil.h"
@import ObjectiveC;

@implementation NSUserDefaults (ZZFoundation)

- (BOOL)zz_hasKey:(NSString *)key
{
    return [self objectForKey:key] != nil;
}

#pragma mark - Accessor generator
#pragma mark -
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if ([self zz_generateAccessor:sel inClass:self]) {
        return YES;
    } else {
        return [super resolveInstanceMethod:sel];
    }
}

+ (BOOL)zz_generateAccessor:(SEL)selector inClass:(Class)clazz
{
    BOOL isSuccess = NO;
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(clazz, &count);
    
    for (int i = 0; i < count; ++i) {
        objc_property_t property = properties[i];
        char *dynamicAttrValue = property_copyAttributeValue(property, "D");
        if (dynamicAttrValue == NULL) {
            continue;   // If the property is not @dynamic, DO NOT add method dynamicaly.
        }
        
        const char *name = property_getName(property);
        const char *attributes = property_getAttributes(property);
        
        char *getter = strstr(attributes, ",G");
        if (getter) {
            getter = strdup(getter + 2);
            getter = strsep(&getter, ",");
        } else {
            getter = strdup(name);
        }
        SEL getterSel = sel_registerName(getter);
        free(getter);
        
        char *setter = strstr(attributes, ",S");
        if (setter) {
            setter = strdup(setter + 2);
            setter = strsep(&setter, ",");
        } else {
            asprintf(&setter, "set%c%s:", toupper(name[0]), name + 1);
        }
        SEL setterSel = sel_registerName(setter);
        free(setter);
        
        if (selector != getterSel && selector != setterSel) {
            continue;   // Neither getter nor setter
        }
        
        NSString *key = [self zz_keyForPropertyName:name];
        objc_setAssociatedObject(self, getterSel, key, OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, setterSel, key, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        IMP getterImp = NULL;
        IMP setterImp = NULL;
        char type = attributes[1];
        switch (type) {
            case _C_CHR:
            case _C_SHT:
            case _C_INT:
            case _C_LNG:
            case _C_LNG_LNG:
                getterImp = (IMP)zz_integerGetter;
                setterImp = (IMP)zz_integerSetter;
                break;
                
            case _C_UCHR:
            case _C_USHT:
            case _C_UINT:
            case _C_ULNG:
            case _C_ULNG_LNG:
                getterImp = (IMP)zz_unsignedIntegerGetter;
                setterImp = (IMP)zz_unsignedIntegerSetter;
                break;
                
            case _C_BOOL:
                getterImp = (IMP)zz_boolGetter;
                setterImp = (IMP)zz_boolSetter;
                break;
                
            case _C_FLT:
                getterImp = (IMP)zz_floatGetter;
                setterImp = (IMP)zz_floatSetter;
                break;
                
            case _C_DBL:
                getterImp = (IMP)zz_doubleGetter;
                setterImp = (IMP)zz_doubleSetter;
                break;
                
            case _C_ID: {
                char *urlType = strstr(attributes, "NSURL");
                if (urlType) {
                    getterImp = (IMP)zz_URLGetter;
                    setterImp = (IMP)zz_URLSetter;
                } else {
                    getterImp = (IMP)zz_objectGetter;
                    setterImp = (IMP)zz_objectSetter;
                }
                break;
            }
                
            default:
                free(properties);
                [NSException raise:NSInternalInconsistencyException format:@"Unsupported type of property \"%s\" in class %@", name, self];
                break;
        }
        
        char types[5];
        
        if (selector == getterSel) {
            snprintf(types, 4, "%c@:", type);
            class_addMethod(clazz, getterSel, getterImp, types);
        } else {
            snprintf(types, 5, "v@:%c", type);
            class_addMethod(clazz, setterSel, setterImp, types);
        }
        
        isSuccess = YES;
        break;
    }
    
    free(properties);
    
    return isSuccess;
}

+ (NSString *)zz_keyForPropertyName:(char const *)propertyName
{
    return [NSString stringWithUTF8String:propertyName];
}

+ (NSString *)zz_keyForSelector:(SEL)selector
{
    return objc_getAssociatedObject(self, selector);
}

#pragma mark - Getter and Setter
#pragma mark -
static NSInteger zz_integerGetter(id self, SEL _cmd) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    return [self integerForKey:key];
}

static void zz_integerSetter(id self, SEL _cmd, NSInteger value) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    [self setInteger:value forKey:key];
}

static NSUInteger zz_unsignedIntegerGetter(id self, SEL _cmd) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    return [[self objectForKey:key] unsignedIntegerValue];
}

static void zz_unsignedIntegerSetter(id self, SEL _cmd, NSUInteger value) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    [self setObject:@(value) forKey:key];
}

static bool zz_boolGetter(id self, SEL _cmd) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    return [self boolForKey:key];
}

static void zz_boolSetter(id self, SEL _cmd, bool value) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    [self setBool:value forKey:key];
}

static float zz_floatGetter(id self, SEL _cmd) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    return [self floatForKey:key];
}

static void zz_floatSetter(id self, SEL _cmd, float value) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    [self setFloat:value forKey:key];
}

static double zz_doubleGetter(id self, SEL _cmd) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    return [self doubleForKey:key];
}

static void zz_doubleSetter(id self, SEL _cmd, double value) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    [self setDouble:value forKey:key];
}

static id zz_URLGetter(id self, SEL _cmd) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    return [self URLForKey:key];
}

static void zz_URLSetter(id self, SEL _cmd, id object) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    if (object) {
        [self setURL:object forKey:key];
    } else {
        [self removeObjectForKey:key];
    }
}

static id zz_objectGetter(id self, SEL _cmd) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    return [self objectForKey:key];
}

static void zz_objectSetter(id self, SEL _cmd, id object) {
    NSString *key = [[self class] zz_keyForSelector:_cmd];
    if (object) {
        [self setObject:object forKey:key];
    } else {
        [self removeObjectForKey:key];
    }
}

@end
