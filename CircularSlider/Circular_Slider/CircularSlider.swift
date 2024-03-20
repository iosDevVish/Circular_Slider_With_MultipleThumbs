import UIKit

@IBDesignable
class CircularSlider: UIControl {
    
    private var circularSliderLayer: CircularSliderLayer {
        return layer as! CircularSliderLayer
    }
    
    private var activeThumbIndex: Int?
    
    @IBInspectable
    var minimumValue: Float = 0 {
        didSet {
            circularSliderLayer.minimumValue = minimumValue
            updateLayer()
        }
    }
    
    @IBInspectable
    var maximumValue: Float = 24 {
        didSet {
            circularSliderLayer.maximumValue = maximumValue
            updateLayer()
        }
    }
    
    @IBInspectable
    var thumbRadius: CGFloat = 20 {
        didSet {
            updateLayer()
        }
    }
    
    @IBInspectable
    var circleRadius: CGFloat = 100 {
        didSet {
            updateLayer()
        }
    }
    
    var thumbImages: [UIImage] = [UIImage(named: "A")!, UIImage(named: "B")!, UIImage(named: "C")!, UIImage(named: "D")!, UIImage(named: "E")!] {
        didSet {
            updateLayer()
        }
    }
    
    var currentValues: [Float] = [12] {
        didSet {
            circularSliderLayer.currentValues = currentValues
            updateLayer()
        }
    }
    
    override class var layerClass: AnyClass {
        return CircularSliderLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        circularSliderLayer.contentsScale = UIScreen.main.scale
        updateLayer()
    }
    
    private func updateLayer() {
        circularSliderLayer.thumbRadius = thumbRadius
        circularSliderLayer.circleRadius = circleRadius
        circularSliderLayer.thumbImages = thumbImages
        circularSliderLayer.setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circularSliderLayer.frame = bounds
    }
    
//    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        let touchPoint = touch.location(in: self)
//        for (index, value) in currentValues.enumerated() {
//            let thumbAngle = circularSliderLayer.angleForValue(value: value)
//            let thumbCenter = circularSliderLayer.pointOnCircle(angle: thumbAngle, radius: circleRadius)
//            let thumbRect = CGRect(x: thumbCenter.x - thumbRadius, y: thumbCenter.y - thumbRadius, width: 2 * thumbRadius, height: 2 * thumbRadius)
//
//            if thumbRect.contains(touchPoint) {
//                activeThumbIndex = index
//                circularSliderLayer.isTracking = true
//                sendActions(for: .touchDown)
//                return true
//            }
//        }
//        return false
//    }
    
//    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        guard let activeThumbIndex = activeThumbIndex else {
//            return false
//        }
//
//        let touchPoint = touch.location(in: self)
//        let angle = angleForPoint(point: touchPoint)
//        currentValues[activeThumbIndex] = valueForAngle(angle: angle)
//        let doubleStr = String(format: "%.2f", (currentValues[activeThumbIndex]))
//        // Print the updated value of the active thumb
//        print("Button1 \(activeThumbIndex + 1) value updated: \(doubleStr)")
//        //print(Int(currentValues[activeThumbIndex]))
//        var currentValue: Double = Double(doubleStr)!
//        var additionalCondition : Bool = false
////        if currentValue == 0 {
////            if additionalCondition == true {
////                // Perform the first set of actions when the value is zero and additional condition is true
////                print("Button \(activeThumbIndex + 1) value updated: 5")
////                additionalCondition = false
////            } else {
////                // Perform the second set of actions when the value is zero, but additional condition is false
////                print("Button \(activeThumbIndex + 1) value updated: 6")
////                //additionalCondition = false
////            }
////        }else if currentValue == 1{
////            print("Button \(activeThumbIndex + 1) value updated: 7")
////        }else if currentValue == 2{
////            print("Button \(activeThumbIndex + 1) value updated: 8")
////        }else if currentValue == 3{
////            print("Button \(activeThumbIndex + 1) value updated: 9")
////        }else if currentValue == 4{
////            print("Button \(activeThumbIndex + 1) value updated: 10")
////        }else if currentValue == 5{
////            print("Button \(activeThumbIndex + 1) value updated: 11")
////        }else if currentValue == 6{
////            print("Button \(activeThumbIndex + 1) value updated: 12")
////        }else if currentValue == 7{
////            print("Button \(activeThumbIndex + 1) value updated: 1")
////        }else if currentValue == 8{
////            print("Button \(activeThumbIndex + 1) value updated: 2")
////        }else if currentValue == 9{
////            print("Button \(activeThumbIndex + 1) value updated: 3")
////        }else if currentValue == 10{
////            print("Button \(activeThumbIndex + 1) value updated: 4")
////        }else if currentValue == 11{
////            print("Button \(activeThumbIndex + 1) value updated: 5")
////        }else if currentValue == -11{
////            print("Button \(activeThumbIndex + 1) value updated: 6")
////        }else if currentValue == -10{
////            print("Button \(activeThumbIndex + 1) value updated: 7")
////        }else if currentValue == -9{
////            print("Button \(activeThumbIndex + 1) value updated: 8")
////        }else if currentValue == -8{
////            print("Button \(activeThumbIndex + 1) value updated: 9")
////        }else if currentValue == -7{
////            print("Button \(activeThumbIndex + 1) value updated: 10")
////        }else if currentValue == -6{
////            print("Button \(activeThumbIndex + 1) value updated: 11")
////        }else if currentValue == -5{
////            print("Button \(activeThumbIndex + 1) value updated: 12")
////        }else if currentValue == -4{
////            print("Button \(activeThumbIndex + 1) value updated: 1")
////        }else if currentValue == -3{
////            print("Button \(activeThumbIndex + 1) value updated: 2")
////        }else if currentValue == -2{
////            print("Button \(activeThumbIndex + 1) value updated: 3")
////        }else if currentValue == -1{
////            print("Button \(activeThumbIndex + 1) value updated: 4")
////            additionalCondition = true
////        }
//        if currentValue > 0.99 || currentValue < 1.99 {
//        print("Button \(activeThumbIndex + 1) value updated: 7")
//        }else if currentValue > 1.99 || currentValue < 2.99{
//            print("Button \(activeThumbIndex + 1) value updated: 8")
//        }else if currentValue > 3.99 || currentValue < 4.99{
//            print("Button \(activeThumbIndex + 1) value updated: 9")
//        }else if currentValue > 4.99 || currentValue < 5.99{
//            print("Button \(activeThumbIndex + 1) value updated: 3")
//        }else if currentValue > 5.99 || currentValue < 6.99{
//            print("Button \(activeThumbIndex + 1) value updated: 5")
//        }else if currentValue > 6.99 || currentValue < 7.99{
//            print("Button \(activeThumbIndex + 1) value updated: 6")
//        }else if currentValue > 6.99 || currentValue < 7.99{
//            print("Button \(activeThumbIndex + 1) value updated: 7")
//        }else if currentValue > 6.99 || currentValue < 7.99{
//            print("Button \(activeThumbIndex + 1) value updated: 8")
//        }else if currentValue > 6.99 || currentValue < 7.99{
//            print("Button \(activeThumbIndex + 1) value updated: 9")
//        }else if currentValue > 6.99 || currentValue < 7.99{
//            print("Button \(activeThumbIndex + 1) value updated: 10")
//        }else if currentValue < 11.06 || currentValue == -10.21{
//            print("Button \(activeThumbIndex + 1) value updated: 11")
//        }else if currentValue < -10.21 || currentValue == -9.24{
//            print("Button \(activeThumbIndex + 1) value updated: 12")
//        }else if  currentValue < -8.28 || currentValue == -7.43{
//            print("Button \(activeThumbIndex + 1) value updated: 1")
//        }else if currentValue < -6.02 || currentValue == -5.10{
//            print("Button \(activeThumbIndex + 1) value updated: 2")
//        }else if currentValue < 3.71 || currentValue == -2.85{
//            print("Button \(activeThumbIndex + 1) value updated: 3")
//        }else if currentValue < -2.01 || currentValue == -1.98{
//            print("Button \(activeThumbIndex + 1) value updated: 4")
//        }else if currentValue < 0.03 || currentValue == 0.45{
//            print("Button \(activeThumbIndex + 1) value updated: 5")
//        }else if currentValue < 1.05 || currentValue == 2.01{
//            print("Button \(activeThumbIndex + 1) value updated: 6")
//        }else if currentValue < 3.98 || currentValue == 4.50{
//            print("Button \(activeThumbIndex + 1) value updated: 7")
//        }else if currentValue < 5.25 || currentValue == 6.89{
//            print("Button \(activeThumbIndex + 1) value updated: 8")
//        }else if currentValue < 6.89 || currentValue == 8.98{
//            print("Button \(activeThumbIndex + 1) value updated: 9")
//        }else if currentValue < 10.78 || currentValue == 11.98{
//            print("Button \(activeThumbIndex + 1) value updated: 10")
//        }else if currentValue < -11.28 || currentValue == -10.86{
//            print("Button \(activeThumbIndex + 1) value updated: 11")
//        }else if currentValue < -9.33 || currentValue == -7.08 {
//            print("Button \(activeThumbIndex + 1) value updated: 12")
//        }
//
////        if currentValue < 0.88 || currentValue == 0.00 {
////        print("Button \(activeThumbIndex + 1) value updated: 6")
////        }else if currentValue < 0.98 || currentValue == 1.09{
////            print("Button \(activeThumbIndex + 1) value updated: 7")
////        }else if currentValue < 1.28 || currentValue == 1.89{
////            print("Button \(activeThumbIndex + 1) value updated: 8")
////        }else if currentValue < 1.89 || currentValue == 2.82{
////            print("Button \(activeThumbIndex + 1) value updated: 9")
////        }else if currentValue < 2.64 || currentValue == 3.63{
////            print("Button \(activeThumbIndex + 1) value updated: 10")
////        }else if currentValue < 3.58 || currentValue == 5.00{
////            print("Button \(activeThumbIndex + 1) value updated: 11")
////        }else if currentValue < 4.66 || currentValue == 5.81{
////            print("Button \(activeThumbIndex + 1) value updated: 12")
////        }else if currentValue < 1.59 || currentValue == 1.72{
////            print("Button \(activeThumbIndex + 1) value updated: 8")
////        }else if currentValue < 2.40 || currentValue == 2.87{
////            print("Button \(activeThumbIndex + 1) value updated: 9")
////        }else if currentValue < 10.13 || currentValue == 11.10{
////            print("Button \(activeThumbIndex + 1) value updated: 10")
////        }else if currentValue < 11.06 || currentValue == -10.21{
////            print("Button \(activeThumbIndex + 1) value updated: 11")
////        }else if currentValue < -10.21 || currentValue == -9.24{
////            print("Button \(activeThumbIndex + 1) value updated: 12")
////        }else if  currentValue < -8.28 || currentValue == -7.43{
////            print("Button \(activeThumbIndex + 1) value updated: 1")
////        }else if currentValue < -6.02 || currentValue == -5.10{
////            print("Button \(activeThumbIndex + 1) value updated: 2")
////        }else if currentValue < 3.71 || currentValue == -2.85{
////            print("Button \(activeThumbIndex + 1) value updated: 3")
////        }else if currentValue < -2.01 || currentValue == -1.98{
////            print("Button \(activeThumbIndex + 1) value updated: 4")
////        }else if currentValue < 0.03 || currentValue == 0.45{
////            print("Button \(activeThumbIndex + 1) value updated: 5")
////        }else if currentValue < 1.05 || currentValue == 2.01{
////            print("Button \(activeThumbIndex + 1) value updated: 6")
////        }else if currentValue < 3.98 || currentValue == 4.50{
////            print("Button \(activeThumbIndex + 1) value updated: 7")
////        }else if currentValue < 5.25 || currentValue == 6.89{
////            print("Button \(activeThumbIndex + 1) value updated: 8")
////        }else if currentValue < 6.89 || currentValue == 8.98{
////            print("Button \(activeThumbIndex + 1) value updated: 9")
////        }else if currentValue < 10.78 || currentValue == 11.98{
////            print("Button \(activeThumbIndex + 1) value updated: 10")
////        }else if currentValue < -11.28 || currentValue == -10.86{
////            print("Button \(activeThumbIndex + 1) value updated: 11")
////        }else if currentValue < -9.33 || currentValue == -7.08 {
////            print("Button \(activeThumbIndex + 1) value updated: 12")
////        }
//
//
//        sendActions(for: .valueChanged)
//        return true
//    }
    
//    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
//        circularSliderLayer.isTracking = false
//        sendActions(for: .touchUpInside)
//        activeThumbIndex = nil
//    }
    // Inside CircularSlider

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        circularSliderLayer.handleTouch(at: touchPoint)
        sendActions(for: .touchDown)
        
        return true
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        circularSliderLayer.handleDrag(at: touchPoint)
        sendActions(for: .valueChanged)
        
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        circularSliderLayer.endDrag()
        sendActions(for: .touchUpInside)
    }
//
//    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        guard let activeThumbIndex = activeThumbIndex else {
//            return false
//        }
//
//        let touchPoint = touch.location(in: self)
//        circularSliderLayer.handleDrag(at: touchPoint)
//
//        sendActions(for: .valueChanged)
//        return true
//    }
//
//    // Inside endTracking method
//    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
//        circularSliderLayer.endDrag()
//        circularSliderLayer.isTracking = false
//        sendActions(for: .touchUpInside)
//        activeThumbIndex = nil
//    }
    
    func angleForPoint(point: CGPoint) -> CGFloat {
        let deltaX = point.x - bounds.midX
        let deltaY = point.y - bounds.midY
        return atan2(deltaY, deltaX)
    }
    
    func valueForAngle(angle: CGFloat) -> Float {
        let valueRange = maximumValue - minimumValue
        let normalizedAngle = angle.truncatingRemainder(dividingBy: CGFloat(2 * Double.pi))
        let normalizedValue = Float(normalizedAngle / (2 * CGFloat(Double.pi)))
        return minimumValue + normalizedValue * valueRange
    }
}
