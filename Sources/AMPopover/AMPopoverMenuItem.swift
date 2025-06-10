import UIKit

public class AMPopoverMenuItem: NSObject {
    public var title: String
    
    public init(title: String) {
        self.title = title
        super.init()
    }
    
    public static func item(with title: String) -> AMPopoverMenuItem {
        return AMPopoverMenuItem(title: title)
    }
}
