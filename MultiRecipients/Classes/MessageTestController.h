#import "SearchTestController.h"

@class MockDataSource;

@interface MessageTestController : TTViewController
  <TTMessageControllerDelegate ,SearchTestControllerDelegate> {
  NSTimer* _sendTimer;
  NSUInteger _recipientField;
}

@end

