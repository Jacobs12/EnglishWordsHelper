//
//  MYWordListTableViewCell.h
//  MYWordList
//
//  Created by wolffy on 2022/10/14.
//

#import <UIKit/UIKit.h>
#import "MyWordsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYWordListTableViewCell : UITableViewCell

@property (nonatomic,strong) MyWordsModel * model;

@property (nonatomic,strong) IBOutlet UILabel * enLabel;
@property (nonatomic,strong) IBOutlet UILabel * chnLabel;

@end

NS_ASSUME_NONNULL_END
