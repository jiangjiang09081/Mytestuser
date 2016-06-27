//
//  OATTTAttributedLabel.m
//  mobileOa
//
//  Created by sdy on 15-3-12.
//  Copyright (c) 2015年 sdy. All rights reserved.
//

#import "OATTTAttributedLabel.h"

@interface OATTTAttributedLabel () <TTTAttributedLabelDelegate>

@property (nonatomic, strong) NSDictionary *pinkTextLinkAttributes;

@end

@implementation OATTTAttributedLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *keys = [[NSArray alloc] initWithObjects:
                         (id)kCTForegroundColorAttributeName,
                         (id)kCTUnderlineStyleAttributeName, nil];
        
        NSArray *objects = [[NSArray alloc] initWithObjects:
                            _HTTHEME.colorPinkTextColor,
                            [NSNumber numberWithBool:NO], nil];
        
        NSDictionary *linkAttributes = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
        
        self.lineSpacing = 3;
        
        self.linkAttributes = linkAttributes;
        self.activeLinkAttributes = linkAttributes;
        
        NSDictionary *pinkTextLinkAttributes = @{(id)kCTForegroundColorAttributeName:_HTTHEME.colorPinkTextColor,
                                                  (id)kCTUnderlineStyleAttributeName:[NSNumber numberWithBool:NO]};
        
        self.pinkTextLinkAttributes = pinkTextLinkAttributes;
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setDelegate:(id<TTTAttributedLabelDelegate>)delegate {
    [super setDelegate:self];
}

- (void)setText:(id)text {
    [super setText:text];
    
    if ([self.text length] > 0) {
        // 添加粉色标签字体
        NSArray *orderRangeArr = [self pinkTextRangeArr:self.text];
        NSMutableArray *orderCheckingResult = [NSMutableArray arrayWithCapacity:10];
        for (NSValue *value in orderRangeArr) {
            NSRange range = [value rangeValue];
            NSTextCheckingResult *result = [NSTextCheckingResult spellCheckingResultWithRange:range];
            [orderCheckingResult addObject:result];
        }
        if ([orderCheckingResult count] > 0) {
            [self addLinksWithTextCheckingResults:orderCheckingResult attributes:self.pinkTextLinkAttributes];
        }
    }
    
    if (_showAttributes) {
        [self setCallLinkAttributes];
    }
    
    if (_showUrlAttributes) {
        [self addUrlLink];
    }
}

- (void)setShowAttributes:(BOOL)showAttributes {
    _showAttributes = showAttributes;
    if (showAttributes) {
        [self setCallLinkAttributes];
    }
}

- (void)setCallLinkAttributes {
    if ([self.text length] > 0) {
        NSArray *rangeArr = [self rangeOfNameArr:self.text];
        NSMutableArray *checkingResult = [NSMutableArray arrayWithCapacity:10];
        for (NSValue *value in rangeArr) {
            NSRange range = [value rangeValue];
            NSTextCheckingResult *result = [NSTextCheckingResult spellCheckingResultWithRange:range];
            [checkingResult addObject:result];
        }
        [self addLinksWithTextCheckingResults:checkingResult attributes:self.linkAttributes];
    }
}

// 获取粉色标签字体位置
- (NSArray *)pinkTextRangeArr:(NSString *)text {
    NSMutableArray *rangeArr = [NSMutableArray arrayWithCapacity:3];
    
    NSArray *orderTipArr = @[@"【海淘大眼睛】"];
    
    for (NSString *order in orderTipArr) {
        NSRange range = [text rangeOfString:order];
        if (range.length > 1) {
            [rangeArr addObject:[NSValue valueWithRange:range]];
        }
    }
    return rangeArr;
}

// 获取名字标签字体位置
- (NSRange)rangeOfName:(NSString *)text {
    NSRange range1 =  [text rangeOfString:@"@"];
    NSUInteger location = range1.location;
    if (range1.length == 1) {
        NSRange range2 = [[text substringFromIndex:location] rangeOfString:@" "];
        NSRange range;
        if (range2.length == 1) {
            range = NSMakeRange(location, range2.location);
        }
        else {
            range = NSMakeRange(location, [[text substringFromIndex:location] length]);
        }
        return range;
    }
    return NSMakeRange(0, 0);
}

- (NSArray *)rangeOfNameArr:(NSString *)text {
    NSMutableArray *rangeArr = [NSMutableArray arrayWithCapacity:3];
    int lastLocation = 0;
    while ([text length] > 0 && [text isKindOfClass:[NSString class]]) {
        NSRange range1 =  [text rangeOfString:@"@"];
        NSUInteger location = range1.location;

        if (range1.length == 1) {
            NSRange resultRange = [self isInMailRangeArr:range1 withText:text];
            if (resultRange.length > 0) {
                text = [text substringFromIndex:(resultRange.location + resultRange.length)];
                lastLocation += (resultRange.location + resultRange.length);
            }
            else {
                NSRange range2 = [[text substringFromIndex:location] rangeOfString:@" "];
                NSRange range;
                if (range2.length == 1) {
                    range = NSMakeRange(lastLocation + location, range2.location);
                    text = [text substringFromIndex:(range2.location + location + 1)];
                    lastLocation += (range2.location + location + 1);
                }
                else {
                    NSRange range3 = [[text substringFromIndex:location] rangeOfString:@"\n"];
                    if (range3.length == 1) {
                        range = NSMakeRange(lastLocation + location, range3.location);
                        text = [text substringFromIndex:(range3.location + location + 1)];
                        lastLocation += (range3.location + location + 1);
                    }
                    else {
                        NSString *str = [text substringFromIndex:location];
                        range = NSMakeRange(lastLocation + location, [str length]);
                        text = @"";
                        lastLocation += [str length];
                    }
                }
                [rangeArr addObject:[NSValue valueWithRange:range]];
                if ([text length] == 0) {
                    break;
                }
            }
        }
        else {
            text = @"";
        }
    }
    return rangeArr;
}

// 获取email标签位置
- (NSArray *)getMailRangeArrWithText:(NSString *)text {
    NSError *error;
    int length = 0;
    NSMutableArray *rangeArr = [NSMutableArray arrayWithCapacity:10];
    while ([text length] > 0) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*" options:0 error:&error];
        if (regex != nil) {
            NSTextCheckingResult *firstMatch = [regex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
            if (firstMatch) {
                NSRange resultRange = [firstMatch rangeAtIndex:0]; //等同于 firstMatch.range --- 相匹配的范围
                //                NSString *result = [text substringWithRange:resultRange];
                
                NSRange newRange = NSMakeRange(length + resultRange.location, resultRange.length);
                
                text = [self.text substringFromIndex:length + resultRange.location + resultRange.length];
                
                length += resultRange.length + resultRange.location;
                
                [rangeArr addObject:[NSValue valueWithRange:newRange]];
            }
            else {
                text = @"";
            }
        }
        else {
            text = @"";
        }
    }
    return rangeArr;
}

- (NSRange)isInMailRangeArr:(NSRange)range withText:(NSString *)text {
    NSArray *mailRangeArr = [self getMailRangeArrWithText:text];
    BOOL isMail = NO;
    if (range.length == 1) {
        for (NSValue *value in mailRangeArr) {
            NSRange tRange = [value rangeValue];
            isMail = (range.location >= tRange.location) && (range.location <= (tRange.location + tRange.length));
            if (isMail) {
                return tRange;
            }
        }
    }
    return NSMakeRange(0, 0);
}

- (void)addUrlLink {
    NSError *error;
    NSString *text = self.text;
    int length = 0;
    NSMutableArray *rangeArr = [NSMutableArray arrayWithCapacity:10];
    while ([text length] > 0) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"https?+:[^\\s]*\n?" options:0 error:&error];
        if (regex != nil) {
            NSTextCheckingResult *firstMatch = [regex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
            if (firstMatch) {
                NSRange resultRange = [firstMatch rangeAtIndex:0];
//              等同于 firstMatch.range --- 相匹配的范围
//              NSString *result = [text substringWithRange:resultRange];
                
                NSRange newRange = NSMakeRange(length + resultRange.location, resultRange.length);
                
                text = [self.text substringFromIndex:length + resultRange.location + resultRange.length];
                
                length += resultRange.length + resultRange.location;
                
                [rangeArr addObject:[NSValue valueWithRange:newRange]];
            }
            else {
                text = @"";
            }
        }
        else {
            text = @"";
        }
    }
    
    NSMutableArray *checkingResult = [NSMutableArray arrayWithCapacity:10];
    for (NSValue *value in rangeArr) {
        NSRange range = [value rangeValue];
        NSTextCheckingResult *result = [NSTextCheckingResult spellCheckingResultWithRange:range];
        [checkingResult addObject:result];
    }
    
    if ([checkingResult count] > 0) {
        [self addLinksWithTextCheckingResults:checkingResult attributes:self.linkAttributes];
    }
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result {
    NSRange range = result.range;
    NSString *selectText = [self.text substringWithRange:range];
    
    if ([selectText length] > 0) {
        
    }
}

@end
