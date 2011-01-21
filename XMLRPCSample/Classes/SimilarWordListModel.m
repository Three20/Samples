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

#import "SimilarWordListModel.h"
#import <extThree20XMLRPC/extThree20XMLRPC.h>

@implementation SimilarWordListModel

@synthesize searchWordList = _searchWordList;
@synthesize resultWordList = _resultWordList;

-(id)initWithWordList:(NSArray *)list {
	if(self=[self init]) {
  	self.searchWordList = list;
  }
  return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_searchWordList);
  TT_RELEASE_SAFELY(_resultWordList);
	[super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:_searchWordList, @"wordlist", nil];
    
  // Hatena SimilarWord API
  // http://bit.ly/hatenaSimilarWord
	TTURLXMLRPCRequest *req = [[[TTURLXMLRPCRequest alloc] initWithURL:@"http://d.hatena.ne.jp/xmlrpc" 
  																													  method:@"hatena.getSimilarWord"
                                                           parameter:param
                                                            delegate:self] autorelease];
  [req setCachePolicy:cachePolicy];
  [req setCacheExpirationAge:TT_CACHE_EXPIRATION_AGE_NEVER];
	if(![req send]) [self didStartLoad];
}


- (void)requestDidFinishLoad:(TTURLRequest *)request {
	TTURLXMLRPCResponse *res = (TTURLXMLRPCResponse *)request.response;
  NSArray *wordList = [[res object] objectForKey:@"wordlist"];
  NSMutableArray *buf = [[NSMutableArray alloc] init];
  for(NSDictionary *dic in wordList) {
  	[buf addObject:[dic valueForKey:@"word"]];
  }
  _resultWordList = [[NSArray alloc] initWithArray:buf];
  [buf release];
  NSLog(@"%@",_resultWordList);
  [super requestDidFinishLoad:request];
}

- (void)request:(TTURLRequest *)request didFailLoadWithError:(NSError *)error {
	NSLog(@"Fail: %@",error);
  TTAlert([[error userInfo] valueForKey:@"fault"]);
  [super request:request didFailLoadWithError:error];
}

@end
