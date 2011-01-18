#import "ComposerViewController.h"


@implementation ComposerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    _fields = [[NSArray alloc] initWithObjects:
               [[[TTMessageRecipientField alloc] initWithTitle: TTLocalizedString(@"To:", @"")
                                                      required: YES] autorelease],
               [[[TTMessageRecipientField alloc] initWithTitle: TTLocalizedString(@"CC:", @"")
                                                      required: NO] autorelease],
               [[[TTMessageSubjectField alloc] initWithTitle: TTLocalizedString(@"Subject:", @"")
                                                    required: NO] autorelease],
               nil];    
  }
  
  return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  if ([textField isKindOfClass:[TTPickerTextField class]]) {
      for (int i = 0; i < _fields.count; ++i) {
        id field = [_fieldViews objectAtIndex:i];
        if (field == textField) {
          switch (i) {
            case 0: {
              id ccField = [_fieldViews objectAtIndex:1];
              [(id)textField setDataSource:[ccField dataSource]];
              [ccField setDataSource:nil];
              break;
            }
            case 1: {
              id toField = [_fieldViews objectAtIndex:0];
              [(id)textField setDataSource:[toField dataSource]];
              [toField setDataSource:nil];
              break;
            }
            default:
              break;
          }
        }
      }
      // what is it's index
  }
  return YES;
}
@end
