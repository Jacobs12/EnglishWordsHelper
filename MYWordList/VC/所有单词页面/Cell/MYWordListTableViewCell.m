//
//  MYWordListTableViewCell.m
//  MYWordList
//
//  Created by wolffy on 2022/10/14.
//

#import "MYWordListTableViewCell.h"

@implementation MYWordListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MyWordsModel *)model{
    _model = model;
    self.enLabel.text = [NSString stringWithFormat:@"%@",model.en];
    self.chnLabel.text = [NSString stringWithFormat:@"%@",model.chn];
}

@end
