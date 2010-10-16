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

#import "SimilarWordListDataSource.h"
#import "SimilarWordListModel.h"

@implementation SimilarWordListDataSource

- (NSArray *)searchWordList { return _myModel.searchWordList; }

- (id<TTModel>)model { return _myModel; }

-(id)initWithWordList:(NSArray *)list {
	if(self=[self init]) {
  	_myModel = [[SimilarWordListModel alloc] initWithWordList:list];
  }
  return self;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray *items = [NSMutableArray array];
	for(NSString *word in _myModel.resultWordList) {
  	NSString *URL = [NSString stringWithFormat:@"tt://words/%@",[word stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
  	[items addObject:[TTTableTextItem itemWithText:word URL:URL]];
  }
  self.items = items;
  [super tableViewDidLoadModel:tableView];
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_myModel);
  [super dealloc];
}

@end
