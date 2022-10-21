//
//  MyWordsModel.m
//  MYWordList
//
//  Created by wolffy on 2022/10/14.
//

#import "MyWordsModel.h"

@implementation MyWordsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (CGFloat)viewHeight{
    NSString * chn = [NSString stringWithFormat:@"%@",self.chn];
    CGSize size = [chn boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20.0 * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular]} context:nil].size;
    CGFloat height = 16.0 + 20.5 + 8.0 + size.height + 20.0;
    return height;
}

@end
