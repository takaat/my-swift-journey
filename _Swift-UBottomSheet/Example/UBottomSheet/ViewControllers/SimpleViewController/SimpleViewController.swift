import UIKit
import UBottomSheet

class SimpleViewController: UIViewController {
    var sheetCoordinator: UBottomSheetCoordinator!
    var sheetVC: DraggableItem!
    var useNavController = false
    var dataSource: UBottomSheetCoordinatorDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        guard sheetCoordinator == nil else {return}
        sheetCoordinator = UBottomSheetCoordinator(parent: self)
        if dataSource != nil{
            sheetCoordinator.dataSource = dataSource!
        }
        
        let vc: UIViewController
        if useNavController{
            vc = UINavigationController(rootViewController: sheetVC)
            sheetVC.title = "Navigation Bar Title"
        }else{
            vc = sheetVC
        }
        sheetVC.sheetCoordinator = sheetCoordinator
        sheetCoordinator.addSheet(vc, to: self, didContainerCreate: { container in
            let f = self.view.frame
            let rect = CGRect(x: f.minX, y: f.minY, width: f.width, height: f.height)
            container.roundCorners(corners: [.topLeft, .topRight], radius: 10, rect: rect)
        })
    }    
}
