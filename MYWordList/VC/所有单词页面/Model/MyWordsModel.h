//
//  MyWordsModel.h
//  MYWordList
//
//  Created by wolffy on 2022/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyWordsModel : NSObject

@property (nonatomic,copy) NSString * en;
@property (nonatomic,copy) NSString * chn;
@property (nonatomic,copy) NSString * status;

- (CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END
