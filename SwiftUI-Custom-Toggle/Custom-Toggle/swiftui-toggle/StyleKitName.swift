import UIKit

public class StyleKitName: NSObject {
    // Cache
    private struct Cache {
        static var volume: UIImage?

    }

    // Images
    @objc dynamic public class var volume: UIImage {
        if Cache.volume == nil {
            Cache.volume = UIImage(named: "volume")!
        }
        return Cache.volume!
    }

    // Drawing Methods
    @objc dynamic public class func drawCanvas1(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 500, height: 300), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 500, height: 300), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 500, y: resizedFrame.height / 300)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 190.24, y: 187.5))
        bezierPath.addCurve(to: CGPoint(x: 190.24, y: 146.09), controlPoint1: CGPoint(x: 189.83, y: 137.33), controlPoint2: CGPoint(x: 190.24, y: 146.09))
        bezierPath.addLine(to: CGPoint(x: 217.5, y: 146.09))
        UIColor.black.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()

        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 190.24, y: 187.5))
        bezier3Path.addCurve(to: CGPoint(x: 190.24, y: 146.09), controlPoint1: CGPoint(x: 189.83, y: 137.33), controlPoint2: CGPoint(x: 190.24, y: 146.09))
        bezier3Path.addLine(to: CGPoint(x: 217.5, y: 146.09))
        UIColor.black.setStroke()
        bezier3Path.lineWidth = 1
        bezier3Path.stroke()

        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 190.5, y: 187.5))
        bezier2Path.addLine(to: CGPoint(x: 217.5, y: 187.5))
        bezier2Path.addLine(to: CGPoint(x: 190.5, y: 187.5))
        bezier2Path.close()
        UIColor.gray.setFill()
        bezier2Path.fill()
        UIColor.black.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        context.restoreGState()

    }
    
    @objc(StyleKitNameResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
