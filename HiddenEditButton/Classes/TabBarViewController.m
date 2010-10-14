//
// Copyright 2009-2010 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "TabBarViewController.h"

#import <Three20/Three20+Additions.h> // For setTabURLs


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TabBarViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
  [self setTabURLs:[NSArray arrayWithObjects:
                    @"tt://page/1",
                    @"tt://page/2",
                    @"tt://page/3",
                    @"tt://page/4",
                    @"tt://page/5",
                    @"tt://page/6",
                    nil]];

  self.customizableViewControllers = nil;

  // Due to a bug in iOS 4.0, we need to manually hide the edit button when the edit controller
  // appears.
  NSString* systemVersion = [[UIDevice currentDevice] systemVersion];
  if ([systemVersion versionStringCompare:@"4.0"] >= 0
      && [systemVersion versionStringCompare:@"4.1"] < 0) {
    self.moreNavigationController.delegate = self;
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)navigationController: (UINavigationController *)navigationController
      willShowViewController: (UIViewController *)viewController
                    animated: (BOOL)animated {
  UINavigationBar* morenavbar = navigationController.navigationBar;
  UINavigationItem* morenavitem = morenavbar.topItem;
  morenavitem.rightBarButtonItem = nil;
}


@end
