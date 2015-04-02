//
//  NSString+Extension.m
//  BaseFramework
//
//  Created by wendongsheng on 15/4/1.
//  Copyright (c) 2015年 wendongsheng. All rights reserved.
//

#import "NSString+Extension.h"
#import <commoncrypto/CommonDigest.h>

@implementation NSString (Extension)

- (NSString *)ew_removeSpacesAndLineBreaks{
    return [[self stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

- (BOOL)ew_hasSubString:(NSString *)subStr{
    BOOL result = FALSE;
    NSRange range = [self rangeOfString:subStr];
    if (range.location != NSNotFound) {
        result = TRUE;
    }
    return result;
}

- (NSString *)ew_replaceString:(NSString *)str withString:(NSString *)aStr{
    return [self stringByReplacingOccurrencesOfString:str withString:aStr];
}

- (CGFloat)ew_heightWithFont:(UIFont *)font lineWidth:(CGFloat)width{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_0
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.height;
#else
    CGSize size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
#endif
    
}

- (CGFloat)ew_widthWithFont:(UIFont *)font lineWidth:(CGFloat)width{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_0
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
    
#else
    CGSize size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return size.wide;
    
#endif
    
}

- (CGFloat)ew_widthWithFont:(UIFont *)font lineHeight:(CGFloat)height{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_0
    CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
    
#else
    CGSize size = [self sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX,height) lineBreakMode:NSLineBreakByWordWrapping];
    return size.wide;
    
#endif

}

- (CGSize)ew_sizeWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode label:(UILabel *)label{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paraphStyle setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paraphStyle range:NSMakeRange(0, self.length)];
    label.attributedText = attributedString;
    NSDictionary *attributdDic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraphStyle};
    CGRect boundingRect = [self boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributdDic context:nil];
    return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
}

- (NSAttributedString *)ew_focusSubstring:(NSString *)subString color:(UIColor *)fontColor font:(UIFont *)font{
    NSAssert(nil != fontColor, @"nil color!");
    NSAssert(nil != font, @"nil font");
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = [self rangeOfString:subString];
    if (range.location != NSNotFound) {
        [attributeString setAttributes:@{NSForegroundColorAttributeName:fontColor, NSFontAttributeName:font} range:range];
    }else{
        NSLog(@"could not find the specified substring");
    }
    return attributeString;
}

- (NSInteger)ew_numberOfLinesWithFont:(UIFont *)font withLineWith:(NSInteger)lineWidth
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_0
    CGRect rect = [self boundingRectWithSize:CGSizeMake(lineWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    NSInteger lines = rect.size.height/[font ew_lineHeight];
    return lines;
    
#else
    CGSize size = [self sizeWithFont:font
                   constrainedToSize:CGSizeMake(lineWidth, CGFLOAT_MAX)
                       lineBreakMode:NSLineBreakByTruncatingTail];
    NSInteger lines = size.height / [font ew_lineHeight];
    return lines;
#endif
}

- (BOOL)ew_checkEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)ew_checkPhoneNumber{
    NSString *phoneRegex = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)ew_checkIDNumber{
    NSString *idRegex = @"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$";
    NSPredicate *idTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",idRegex];
    return [idTest evaluateWithObject:self];
}

- (BOOL)ew_checkPassword{
    NSString *passwordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex];
    return [passwordPredicate evaluateWithObject:self];
}

#pragma mark - 
- (NSString *)ew_md5Encrypt
{
    const char *concat_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
    
}

- (NSString *)ew_base64Encode
{
    return  [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
}

- (NSString *)ew_base64Decode
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)ew_urlEncode
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self,NULL,(CFStringRef)@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`",kCFStringEncodingUTF8));
    
    return result;
}


- (NSString *)ew_urlDecode
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
    
    return result;
}

@end
