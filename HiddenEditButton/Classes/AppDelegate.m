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

#import "AppDelegate.h"

// View Controllers
#import "PageViewController.h"
#import "TabBarViewController.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AppDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationDidFinishLaunching:(UIApplication *)application {
  TTNavigator* navigator = [TTNavigator navigator];
  navigator.persistenceMode = TTNavigatorPersistenceModeAll;

  TTURLMap* map = navigator.URLMap;

  [map from:@"*" toViewController:[TTWebController class]];

  [map from:@"tt://tabBar" toSharedViewController:[TabBarViewController class]];

  [map from:@"tt://page/(initWithPage:)" toSharedViewController:[PageViewController class]];

  if (![navigator restoreViewControllers]) {
    [navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://tabBar"]];
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)navigator:(TTNavigator*)navigator shouldOpenURL:(NSURL*)URL {
  return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
  [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
  return YES;
}


@end
