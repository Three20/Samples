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

#import "AdTableViewController.h"

#import <Three20/Three20+Additions.h>

static const NSTimeInterval kBannerSlideInAnimationDuration = 0.4;


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AdTableViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
  _adView.delegate = nil;
  TT_RELEASE_SAFELY(_adView);

  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
  [super viewDidLoad];

  _adView = [[ADBannerView alloc] initWithFrame:CGRectZero];

  _adView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;

  _adView.requiredContentSizeIdentifiers = [NSSet setWithObjects:
                                            ADBannerContentSizeIdentifier320x50,
                                            ADBannerContentSizeIdentifier480x32,
                                            nil];
  _adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;

  _adView.delegate = self;

  // Set initial frame to be offscreen, at the bottom
  _adView.top = self.view.bottom;

  [self.view addSubview:_adView];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
  [super viewDidUnload];

  _adView.delegate = nil;
  TT_RELEASE_SAFELY(_adView);

  _bannerIsVisible = NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateViewFramesWithOrientation:(UIInterfaceOrientation)orientation {
  if (UIInterfaceOrientationIsLandscape(orientation)) {
    _adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier480x32;

  } else {
    _adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
  }

  CGRect tableFrame = self.tableView.frame;
  tableFrame.size.height = self.view.height - (_bannerIsVisible ? _adView.height : 0);
  self.tableView.frame = tableFrame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self updateViewFramesWithOrientation:self.interfaceOrientation];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)willRotateToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation
                                duration: (NSTimeInterval)duration {
  [self updateViewFramesWithOrientation:toInterfaceOrientation];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {
  self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
                     @"A number of links",
                     [TTTableTextItem itemWithText:@"The first link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"Link" URL:@"tt://adTable"],
                     [TTTableTextItem itemWithText:@"The last link" URL:@"tt://adTable"],
                     nil];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark AdViewBannerDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
  if (!_bannerIsVisible) {
    CGRect tableFrame = self.tableView.frame;

    [UIView beginAnimations:@"showBanner" context:NULL];
    {
      [UIView setAnimationDuration:kBannerSlideInAnimationDuration];

      _adView.bottom = self.tableView.bottom;

      // Shrink the tableview to create space for banner
      tableFrame.size.height = self.view.height - _adView.height;
      self.tableView.frame = tableFrame;

      _bannerIsVisible = YES;
    }
    [UIView commitAnimations];
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
  if (_bannerIsVisible) {
    // Grow the tableview to occupy space left by banner
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height = self.view.height;

    self.tableView.frame = tableFrame;
    _adView.top = self.tableView.bottom;

    _bannerIsVisible = NO;
  }
}


@end
