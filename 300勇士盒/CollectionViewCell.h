//
//  CollectionViewCell.h
//  collectionTest
//
//  Created by ChenHao on 12/10/14.
//  Copyright (c) 2014 xxTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroListModel.h"
@interface CollectionViewCell : UICollectionViewCell

- (void)layout:(HeroListModel *)hero;
@end
