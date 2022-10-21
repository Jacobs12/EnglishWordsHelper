//
//  MYWholeWordsViewController.h
//  MYWordList
//
//  Created by wolffy on 2022/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,MyListType){
    MyListTypeWhole,
    MyListTypeTest
};

@interface MYWholeWordsViewController : UIViewController

@property (nonatomic,copy) NSString * id1;
@property (nonatomic,assign) MyListType type;

@end

NS_ASSUME_NONNULL_END
