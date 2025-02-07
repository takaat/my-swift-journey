import UIKit
import UBottomSheet

class PullToDismissDataSource: UBottomSheetCoordinatorDataSource {
    func sheetPositions(_ availableHeight: CGFloat) -> [CGFloat] {
        return [0.5, 1.1].map{$0*availableHeight} /// Trick is to set bottom position to any value more than available height such as 1.1*availableHeight
    }
    
    func initialPosition(_ availableHeight: CGFloat) -> CGFloat {
        return availableHeight*0.5
    }
}
