//
//  NSString+ZZFoundation.m
//  ZZFoundation
//
//  Created by Walker Stark on 10/23/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "NSString+ZZFoundation.h"
#import "ZZFoundationUtil.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZZFoundation)

#pragma mark - Crypto
#pragma mark -
- (NSString *)zz_MD5String
{
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_SHA1(self.UTF8String, (CC_LONG)strlen(self.UTF8String), digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return [output copy];
}

- (NSString *)zz_SHA1String
{
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.UTF8String, (CC_LONG)strlen(self.UTF8String), digest);

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }

    return [output copy];
}

#pragma mark - Quoted string
#pragma mark -
- (NSString *)zz_quotedString
{
    id bQuote = [NSLocale.currentLocale objectForKey:NSLocaleQuotationBeginDelimiterKey];
    id eQuote = [NSLocale.currentLocale objectForKey:NSLocaleQuotationEndDelimiterKey];
    return [NSString stringWithFormat:@"%@%@%@", bQuote, self, eQuote];
}

#pragma mark - Validation
#pragma mark -
- (BOOL)zz_isValidEmail
{
    NSTextCheckingResult *result = [self zz_validateForTextCheckingType:NSTextCheckingTypeLink];
    return (result && [result.URL.absoluteString hasPrefix:@"mailto:"]);
}

- (BOOL)zz_isValidPhone
{
    return [self zz_validateForTextCheckingType:NSTextCheckingTypePhoneNumber];
}

- (BOOL)zz_isValidDate
{
    return [self zz_validateForTextCheckingType:NSTextCheckingTypeDate];
}

- (BOOL)zz_isValidURL
{
    return [self zz_validateForTextCheckingType:NSTextCheckingTypeLink];
}

- (NSTextCheckingResult *)zz_validateForTextCheckingType:(NSTextCheckingType)checkingType
{
    if (self.length == 0) return nil;
    
    NSError *error = nil;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:checkingType error:&error];
    if (error) {
        ZZLog(@"Create data detector with error: %@", error.localizedDescription);
        return nil;
    }
    
    NSRange inputRange = NSMakeRange(0, self.length);
    NSTextCheckingResult *result = [detector firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    BOOL isValid = (result && result.resultType == checkingType && NSEqualRanges(result.range, inputRange));
    
    return isValid ? result : nil;
}

@end
