//
// Copyright 2010 LittleApps Inc.
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

#import "SimilarWordListViewController.h"
#import "SimilarWordListDataSource.h"

@implementation SimilarWordListViewController

- (NSArray *)searchWordList { return _myDataSource.searchWordList; }

-(id)initWithWord:(NSString *)word {
	self = [self initWithWordList:[NSArray arrayWithObject:word]];
  self.title = [NSString stringWithFormat:@"Similar words of \"%@\"",word];
  return self;
}

-(id)initWithWordList:(NSArray *)list {
	if(self=[self init]) {
    _myDataSource = [[SimilarWordListDataSource alloc] initWithWordList:list];
  }
  return self;
}

- (void)createModel {
  self.dataSource = _myDataSource;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_myDataSource);
	[super dealloc];
}


@end
