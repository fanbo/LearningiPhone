//
//  HappinessViewController.h
//  Happiness
//
//  Created by Snake on 12-10-10.
//  Copyright (c) 2012年 snake well. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "splitViewbarButtonItemPresenter.h"

@interface HappinessViewController : UIViewController<splitViewbarButtonItemPresenter>
@property (nonatomic) int happiness; //0 is sad;100 is very happy
@end
