//
//  NSString+Extension.h
//  BaseFramework
//
//  Created by wendongsheng on 15/4/1.
//  Copyright (c) 2015年 wendongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

#pragma mark - Tools -

/** remove spaces and line breaks */
- (NSString *)ew_removeSpacesAndLineBreaks;

/** A string has substring */
- (BOOL)ew_hasSubString:(NSString *)subStr;

/** replace string with string */
- (NSString *)ew_replaceString:(NSString *)str withString:(NSString *)aStr;

/**
 *  according to the font size and line width calculation line height
 */
- (CGFloat)ew_heightWithFont:(UIFont *)font lineWidth:(CGFloat)width;

/**
 *  according to the font size and line Max width calculation line width
 */
- (CGFloat)ew_widthWithFont:(UIFont *)font lineWidth:(CGFloat)width;

/**
 *  according to the font size and line Max height calculation line width
 */
- (CGFloat)ew_widthWithFont:(UIFont *)font lineHeight:(CGFloat)height;

/**
 *  focus substing in string
 */
- (NSAttributedString *)ew_focusSubstring:(NSString *)subString color:(UIColor *)fontColor font:(UIFont *)font;

/**
 *  number of lines
 */
- (NSInteger)ew_numberOfLinesWithFont:(UIFont *)font withLineWith:(NSInteger)lineWidth;

/**
 *  check email
 */
- (BOOL)ew_checkEmail;

/**
 *  check phone number
 */
- (BOOL)ew_checkPhoneNumber;

/**
 *  check ID number
 */
- (BOOL)ew_checkIDNumber;

/**
 *  check password format
 */
- (BOOL)ew_checkPassword;

#pragma mark - Encode & Decode -
/**
 *  MD5 encrypt
 */
- (NSString *)ew_md5Encrypt;

/**
 *  base64 encode
 */
- (NSString *)ew_base64Encode;

/**
 *  base64 decode
 */
- (NSString *)ew_base64Decode;

/**
 *  url encode
 */
- (NSString *)ew_urlEncode;

/**
 *  url decode
 */
- (NSString *)ew_urlDecode;



@end
