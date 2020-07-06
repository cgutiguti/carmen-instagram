//
//  ComposeViewController.h
//  Carmen-Instagram
//
//  Created by Carmen Gutierrez on 7/6/20.
//  Copyright © 2020 Carmen Gutierrez. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ComposeViewControllerDelegate



@end
@interface ComposeViewController : UIViewController
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
